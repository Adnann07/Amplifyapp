import 'dart:convert';
import 'package:http/http.dart' as http;
import 'sms_service.dart';

class SubscriptionService {
  // Call AppLink directly, not your own server
  static const String baseUrl = 'https://api.applink.com.bd';

  static const String applicationId = 'APP_018634';
  static const String password = '80780519b71e5be892c8bca38a039f53';

  static String? _currentReferenceNo;
  static String? _currentPhoneNumber;
  static bool _isSubscribed = false;

  static bool get isSubscribed => _isSubscribed;
  static String? get phoneNumber => _currentPhoneNumber;

  // Format Banglalink MSISDN to tel:8801XXXXXXXXX
  static String _formatMsisdn(String phoneNumber) {
    if (phoneNumber.startsWith('tel:')) {
      return phoneNumber;
    }
    final digits = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    // assume user enters 11‑digit local number like 0197xxxxxxx
    return 'tel:880$digits';
  }

  // Request OTP from AppLink
  static Future<Map<String, dynamic>?> requestOtp(String phoneNumber) async {
    try {
      final formattedPhone = _formatMsisdn(phoneNumber);
      print('Requesting OTP for: $formattedPhone');

      final url = Uri.parse('$baseUrl/otp/request');

      final data = {
        "applicationId": applicationId,
        "password": password,
        "subscriberId": formattedPhone,
        // optional but good to send
        "applicationHash": "abcdefgh",
        "applicationMetaData": {
          "client": "MOBILEAPP",
          "device": "Android",
          "os": "android 14",
          "appCode": "https://play.google.com/store/apps/details?id=com.example.amplify"
        }
      };

      print('Request data: ${jsonEncode(data)}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json;charset=utf-8'},
        body: jsonEncode(data),
      );

      print('Response (${response.statusCode}): ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['statusCode'] == 'S1000') {
          _currentReferenceNo = responseData['referenceNo'];
          _currentPhoneNumber = formattedPhone;
        }
        return responseData;
      }
      return null;
    } catch (e) {
      print('OTP Request error: $e');
      return null;
    }
  }

  // Verify OTP and activate subscription
  static Future<Map<String, dynamic>?> verifyOtp(String otp) async {
    if (_currentReferenceNo == null) return null;

    try {
      final url = Uri.parse('$baseUrl/otp/verify');

      final data = {
        "applicationId": applicationId,
        "password": password,
        "referenceNo": _currentReferenceNo,
        "otp": otp,
      };

      print('Verifying OTP with data: ${jsonEncode(data)}');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json;charset=utf-8'},
        body: jsonEncode(data),
      );

      print('Verify Response (${response.statusCode}): ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['statusCode'] == 'S1000' &&
            responseData['subscriptionStatus'] == 'REGISTERED') {
          _isSubscribed = true;

          // Register this MSISDN in your own base using Subscription API
          await SmsService.subscribeUser(_currentPhoneNumber!);
        }
        return responseData;
      }
      return null;
    } catch (e) {
      print('OTP Verify error: $e');
      return null;
    }
  }

  // Check subscription status using Subscription API
  static Future<bool> checkSubscriptionStatus(String? phoneNumber) async {
    if (phoneNumber == null) return false;

    final formattedPhone = _formatMsisdn(phoneNumber);

    final subResponse =
    await SmsService.subscribeUser(formattedPhone, subscribe: true);
    // optional; you can inspect baseSize if needed
    await SmsService.getBaseSize();

    _isSubscribed = subResponse?['statusCode'] == 'S1000' &&
        (subResponse?['subscriptionStatus'] == 'REGISTERED' ||
            subResponse?['subscriptionStatus'] == 'REGISTERED.');

    return _isSubscribed;
  }

  // Reset subscription (for logout)
  static void resetSubscription() {
    _isSubscribed = false;
    _currentReferenceNo = null;
    _currentPhoneNumber = null;
  }
}
