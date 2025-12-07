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
          print('❌ Subscription expired or cancelled - revoking access');
          await _revokeSubscription();
        } else if (isActive && !_isSubscribed) {
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

  // Check if input is the test bypass number
  static bool _isTestBypass(String input) {
    final result = input.trim() == _testBypassNumber;
    print('🔍 Test Bypass Check: input="${input.trim()}", match=$result');
    return result;
  }

  // FIXED: Proper phone number formatting
  static String formatMsisdn(String raw) {
    print('🔍 formatMsisdn called with: "$raw"');

    // Remove all non-digit characters
    final digits = raw.replaceAll(RegExp(r'[^\d]'), '');
    print('🔍 After removing non-digits: "$digits" (${digits.length} chars)');

    String normalized;

    // Handle different input formats
    if (digits.startsWith('880')) {
      // Format: 880XXXXXXXXXX (13 digits) -> take last 10 digits
      if (digits.length >= 13) {
        normalized = digits.substring(3, 13); // Get 10 digits after 880
        print('🔍 Detected 880 prefix, extracted: "$normalized"');
      } else {
        print('❌ Invalid length after 880 prefix: ${digits.length}');
        normalized = digits.substring(3);
      }
    } else if (digits.startsWith('01')) {
      // Format: 01XXXXXXXXX (11 digits) -> take last 10 digits
      if (digits.length >= 11) {
        normalized = digits.substring(1, 11); // Remove leading 0, get 10 digits
        print('🔍 Detected 01 prefix, extracted: "$normalized"');
      } else {
        print('❌ Invalid length with 01 prefix: ${digits.length}');
        normalized = digits.substring(1);
      }
    } else if (digits.startsWith('1') && digits.length == 10) {
      // Format: 1XXXXXXXXX (10 digits)
      normalized = digits;
      print('🔍 Detected 10-digit format starting with 1: "$normalized"');
    } else {
      print('⚠️ Unexpected format, using as-is: "$digits"');
      normalized = digits;
    }

    final formatted = 'tel:880$normalized';
    print('✅ Final formatted MSISDN: "$formatted"');
    return formatted;
  }

  // FIXED: Validate Banglalink number
  static bool _isValidBanglalink(String raw) {
    print('🔍 _isValidBanglalink called with: "$raw"');

    final digits = raw.replaceAll(RegExp(r'[^\d]'), '');
    print('🔍 Digits only: "$digits" (${digits.length} chars)');

    // Normalize to 11-digit format starting with 0
    String normalized;
    if (digits.startsWith('880') && digits.length >= 13) {
      normalized = '0${digits.substring(3, 13)}';
    } else if (digits.startsWith('01') && digits.length >= 11) {
      normalized = digits.substring(0, 11);
    } else if (digits.startsWith('1') && digits.length == 10) {
      normalized = '0$digits';
    } else {
      normalized = digits;
    }

    print('🔍 Normalized: "$normalized" (${normalized.length} chars)');

    // Must be exactly 11 digits starting with 019
    if (normalized.length != 11) {
      print('❌ Invalid length: ${normalized.length} (expected 11)');
      return false;
    }

    if (!normalized.startsWith('019')) {
      print('❌ Does not start with 019');
      return false;
    }

    // Fourth digit should be 1-9 for valid Banglalink prefixes
    final fourthDigit = normalized[3];
    if (!RegExp(r'[1-9]').hasMatch(fourthDigit)) {
      print('❌ Invalid Banglalink prefix: 019$fourthDigit');
      return false;
    }

    print('✅ Valid Banglalink number: $normalized');
    return true;
  }

  static Future<Map<String, dynamic>?> requestOtp(String rawPhoneNumber) async {
    print('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('🔐 REQUEST OTP CALLED');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('📱 Raw input: "$rawPhoneNumber"');

    // TEST BYPASS CHECK
    if (_isTestBypass(rawPhoneNumber)) {
      print('🔓 TEST MODE ACTIVATED');
      _isTestMode = true;
      _currentPhoneNumber = 'test_mode';
      _currentReferenceNo = 'TEST_REF_${DateTime.now().millisecondsSinceEpoch}';

      return {
        'statusCode': 'S1000',
        'statusDetail': 'Test mode - OTP sent',
        'referenceNo': _currentReferenceNo,
      };
    }

    // Validate Banglalink number
    if (!_isValidBanglalink(rawPhoneNumber)) {
      print('❌ VALIDATION FAILED');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
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

      print('\n📤 SENDING REQUEST');
      print('URL: $url');
      print('Payload: ${jsonEncode(data)}');
      print('subscriberId: "$formattedPhone"');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json;charset=utf-8'},
        body: jsonEncode(data),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          print('⏱️ REQUEST TIMEOUT after 30 seconds');
          return http.Response('{"statusCode":"E9999","statusDetail":"Request timeout"}', 408);
        },
      );

      print('\n📥 RESPONSE RECEIVED');
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;

        if (responseData['statusCode'] == 'S1000') {
          _currentReferenceNo = responseData['referenceNo']?.toString();
          _currentPhoneNumber = formattedPhone;
          _isTestMode = false;
          print('✅ OTP REQUEST SUCCESS');
          print('Reference No: $_currentReferenceNo');
        } else {
          print('❌ OTP REQUEST FAILED');
          print('Status Code: ${responseData['statusCode']}');
          print('Status Detail: ${responseData['statusDetail']}');
        }

        return responseData;
      } else {
        print('❌ HTTP ERROR: ${response.statusCode}');
        return {
          'statusCode': 'E${response.statusCode}',
          'statusDetail': 'HTTP Error: ${response.statusCode}',
        };
      }
    } catch (e, st) {
      print('❌ EXCEPTION CAUGHT');
      print('Error: $e');
      print('Stack trace:');
      print(st);
      print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');
      return {
        'statusCode': 'E9999',
        'statusDetail': 'Exception: $e',
      };
    }
  }

  static Future<Map<String, dynamic>?> verifyOtp(String otp) async {
    // TEST BYPASS CHECK
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
      print('❌ No referenceNo stored; cannot verify OTP.');
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

      print('🔐 OTP verify -> $url');
      print('📤 Payload: ${jsonEncode(data)}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json;charset=utf-8'},
        body: jsonEncode(data),
      );

      print('📊 Verify status: ${response.statusCode}');
      print('📥 Verify body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;
        print('📥 Parsed verify response: ${jsonEncode(responseData)}');

        if (responseData['statusCode'] == 'S1000') {
          final subStatus = responseData['subscriptionStatus']?.toString().toUpperCase();

          if (subStatus == 'INITIAL' ||
              subStatus == 'REGISTERED' ||
              subStatus == 'REGISTERED.') {

            print('✅ OTP verified with status: $subStatus');

            if (subStatus == 'INITIAL' && _currentPhoneNumber != null) {
              print('🔄 Completing subscription registration...');
              final subResponse = await SmsService.subscribeUser(
                  _currentPhoneNumber!,
                  subscribe: true
              );

              print('📥 Subscription API response: ${jsonEncode(subResponse)}');
            }

            await _saveSubscriptionState(true, _currentPhoneNumber!);
            print('💾 Subscription confirmed and saved');

            if (_currentPhoneNumber != null && !_isTestMode) {
              await SmsService.sendSms(
                message: 'Welcome to Amplify! Your subscription is now active. Enjoy unlimited access to all features.',
                destinationAddresses: [_currentPhoneNumber!],
              );
            }

            return responseData;
          } else {
            print('❌ Unexpected subscription status: $subStatus');
          }
        } else {
          print('❌ Verification failed with code: ${responseData['statusCode']}');
        }

        return responseData;
      }
      return null;
    } catch (e, st) {
      print('❌ verifyOtp exception: $e');
      print(st);
      return null;
    }
  }

  static Future<bool> checkSubscriptionStatus(String? rawPhoneNumber) async {
    if (rawPhoneNumber == null) return false;

    if (_isTestMode || rawPhoneNumber == 'test_mode') {
      print('🔓 Test mode active - returning subscribed status');
      return _isSubscribed;
    }

    final formattedPhone = formatMsisdn(rawPhoneNumber);
    final subResponse = await SmsService.subscribeUser(formattedPhone, subscribe: true);

    print('📥 Check subscription response: ${jsonEncode(subResponse)}');

    final isActive = subResponse?['statusCode'] == 'S1000' &&
        (subResponse?['subscriptionStatus']?.toString().toUpperCase() == 'REGISTERED' ||
            subResponse?['subscriptionStatus']?.toString().toUpperCase() == 'REGISTERED.');

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
