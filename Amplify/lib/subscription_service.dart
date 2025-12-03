import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'sms_service.dart';

class SubscriptionService {
  static const String baseUrl = 'http://18.206.193.105';
  static const String applicationId = 'APP_018634';
  static const String password = '80780519b71e5be892c8bca38a039f53';

  // Persistent storage keys
  static const String _keyIsSubscribed = 'is_subscribed';
  static const String _keyPhoneNumber = 'phone_number';
  static const String _keyLastCheck = 'last_check_timestamp';

  // TEST BYPASS - Works in ALL build modes
  static const String _testBypassNumber = '67';
  static const String _testBypassOtp = '676767';

  static String? _currentReferenceNo;
  static String? _currentPhoneNumber;
  static bool _isSubscribed = false;
  static bool _isTestMode = false;
  static bool _isInitialized = false;

  static bool get isSubscribed => _isSubscribed;
  static String? get phoneNumber => _currentPhoneNumber;

  // Initialize subscription state from persistent storage
  static Future<void> initialize() async {
    if (_isInitialized) return;

    final prefs = await SharedPreferences.getInstance();

    // Check if previous session was test mode
    final storedPhone = prefs.getString(_keyPhoneNumber);
    if (storedPhone == 'test_mode') {
      print('🔓 Previous test mode session detected');
      _isTestMode = true;
    }

    _isSubscribed = prefs.getBool(_keyIsSubscribed) ?? false;
    _currentPhoneNumber = storedPhone;
    _isInitialized = true;

    print('📱 Subscription initialized - Status: $_isSubscribed, Phone: $_currentPhoneNumber');

    // Check subscription status on app start if we have a phone number
    if (_currentPhoneNumber != null && _currentPhoneNumber != 'test_mode') {
      await _periodicSubscriptionCheck();
    }
  }

  // Periodic check to verify subscription status with server
  static Future<void> _periodicSubscriptionCheck() async {
    final prefs = await SharedPreferences.getInstance();
    final lastCheck = prefs.getInt(_keyLastCheck) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;

    // Check every 5 minutes (300000 ms) or on first launch
    if (now - lastCheck > 300000 || lastCheck == 0) {
      print('🔄 Checking subscription status with server...');

      if (_currentPhoneNumber != null && _currentPhoneNumber != 'test_mode') {
        final isActive = await checkSubscriptionStatus(_currentPhoneNumber);

        if (!isActive && _isSubscribed) {
          // User unsubscribed - revoke access immediately
          print('❌ Subscription expired or cancelled - revoking access');
          await _revokeSubscription();
        } else if (isActive && !_isSubscribed) {
          // User resubscribed elsewhere - grant access
          print('✅ Subscription detected - granting access');
          await _saveSubscriptionState(true, _currentPhoneNumber!);
        }
      }

      await prefs.setInt(_keyLastCheck, now);
    }
  }

  // Save subscription state to persistent storage
  static Future<void> _saveSubscriptionState(bool subscribed, String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsSubscribed, subscribed);
    await prefs.setString(_keyPhoneNumber, phone);
    _isSubscribed = subscribed;
    _currentPhoneNumber = phone;
    print('💾 Saved subscription state: $subscribed');
  }

  // Revoke subscription access
  static Future<void> _revokeSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsSubscribed, false);
    _isSubscribed = false;
    print('🚫 Subscription access revoked');
  }

  // Check if input is the test bypass number - Works in ALL modes
  static bool _isTestBypass(String input) {
    final result = input.trim() == _testBypassNumber;
    print('🔍 Test Bypass Check: input="${input.trim()}", match=$result');
    return result;
  }

  // "01XXXXXXXXX" -> "tel:8801XXXXXXXXX"
  static String formatMsisdn(String raw) {
    final digits = raw.replaceAll(RegExp(r'[^\d]'), '');
    print('Raw phone input: $raw');
    print('Digits only: $digits');

    String msisdn;
    if (digits.startsWith('880')) {
      msisdn = digits;
    } else if (digits.startsWith('01')) {
      msisdn = '880${digits.substring(1)}';
    } else {
      msisdn = '880$digits';
    }

    final formatted = 'tel:$msisdn';
    print('Formatted MSISDN: $formatted');
    return formatted;
  }

  static Future<Map<String, dynamic>?> requestOtp(String rawPhoneNumber) async {
    // TEST BYPASS CHECK - Works in all build modes
    if (_isTestBypass(rawPhoneNumber)) {
      print('🔓 TEST MODE ACTIVATED - Bypass number detected');
      _isTestMode = true;
      _currentPhoneNumber = 'test_mode';
      _currentReferenceNo = 'TEST_REF_${DateTime.now().millisecondsSinceEpoch}';

      return {
        'statusCode': 'S1000',
        'statusDetail': 'Test mode - OTP sent',
        'referenceNo': _currentReferenceNo,
      };
    }

    // Validate Banglalink number (019XXXXXXXX)
    final digits = rawPhoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    if (!digits.startsWith('019') || digits.length != 11) {
      print('❌ Invalid Banglalink number format');
      return {
        'statusCode': 'E1001',
        'statusDetail': 'Only Banglalink numbers (019XXXXXXXX) are supported',
      };
    }

    try {
      final formattedPhone = formatMsisdn(rawPhoneNumber);
      final url = Uri.parse('$baseUrl/otp_proxy.php');

      final data = {
        'action': 'request_otp',
        'applicationId': applicationId,
        'password': password,
        'subscriberId': formattedPhone,
      };

      print('OTP request -> $url');
      print('Payload: ${jsonEncode(data)}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json;charset=utf-8'},
        body: jsonEncode(data),
      );

      print('OTP request status: ${response.statusCode}');
      print('OTP response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData =
        jsonDecode(response.body) as Map<String, dynamic>;

        if (responseData['statusCode'] == 'S1000') {
          _currentReferenceNo = responseData['referenceNo']?.toString();
          _currentPhoneNumber = formattedPhone;
          _isTestMode = false;
          print('Stored referenceNo: $_currentReferenceNo');
        } else {
          print(
              'OTP request failed: ${responseData['statusCode']} - ${responseData['statusDetail']}');
        }

        return responseData;
      }
      return null;
    } catch (e, st) {
      print('requestOtp exception: $e');
      print(st);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> verifyOtp(String otp) async {
    // TEST BYPASS CHECK - Removed kDebugMode, works in all modes
    if (_isTestMode) {
      if (otp == _testBypassOtp) {
        print('🔓 TEST MODE - OTP verification bypassed');
        await _saveSubscriptionState(true, 'test_mode');
        return {
          'statusCode': 'S1000',
          'statusDetail': 'Test mode - Subscription successful',
          'subscriptionStatus': 'REGISTERED',
        };
      } else {
        print('❌ TEST MODE - Invalid test OTP (expected: $_testBypassOtp)');
        return {
          'statusCode': 'E1002',
          'statusDetail': 'Invalid test OTP',
        };
      }
    }

    if (_currentReferenceNo == null) {
      print('No referenceNo stored; cannot verify OTP.');
      return null;
    }

    try {
      final url = Uri.parse('$baseUrl/otp_proxy.php');

      final data = {
        'action': 'verify_otp',
        'applicationId': applicationId,
        'password': password,
        'referenceNo': _currentReferenceNo,
        'otp': otp,
      };

      print('OTP verify -> $url');
      print('Payload: ${jsonEncode(data)}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json;charset=utf-8'},
        body: jsonEncode(data),
      );

      print('Verify status: ${response.statusCode}');
      print('Verify body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData =
        jsonDecode(response.body) as Map<String, dynamic>;

        if (responseData['statusCode'] == 'S1000' &&
            (responseData['subscriptionStatus'] == 'REGISTERED' ||
                responseData['subscriptionStatus'] == 'REGISTERED.')) {

          // Save subscription state persistently
          await _saveSubscriptionState(true, _currentPhoneNumber!);
          print('✅ Subscription confirmed and saved');

          if (_currentPhoneNumber != null && !_isTestMode) {
            await SmsService.subscribeUser(_currentPhoneNumber!, subscribe: true);
          }
        }

        return responseData;
      }
      return null;
    } catch (e, st) {
      print('verifyOtp exception: $e');
      print(st);
      return null;
    }
  }

  static Future<bool> checkSubscriptionStatus(String? rawPhoneNumber) async {
    if (rawPhoneNumber == null) return false;

    // Skip API call for test mode - Works in all modes
    if (_isTestMode) {
      print('🔓 Test mode active - returning subscribed status');
      return _isSubscribed;
    }

    final formattedPhone = formatMsisdn(rawPhoneNumber);
    final subResponse =
    await SmsService.subscribeUser(formattedPhone, subscribe: true);
    await SmsService.getBaseSize();

    final isActive = subResponse?['statusCode'] == 'S1000' &&
        (subResponse?['subscriptionStatus'] == 'REGISTERED' ||
            subResponse?['subscriptionStatus'] == 'REGISTERED.');

    // Update local state based on server response
    if (isActive != _isSubscribed) {
      await _saveSubscriptionState(isActive, formattedPhone);
    }

    return isActive;
  }

  static Future<void> resetSubscription() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIsSubscribed);
    await prefs.remove(_keyPhoneNumber);
    await prefs.remove(_keyLastCheck);

    _isSubscribed = false;
    _currentReferenceNo = null;
    _currentPhoneNumber = null;
    _isTestMode = false;
    _isInitialized = false;

    print('🔄 Subscription reset complete');
  }
}
