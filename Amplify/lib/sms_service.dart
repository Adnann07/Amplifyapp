import 'dart:convert';
import 'package:http/http.dart' as http;

class SmsService {
  static const String baseUrl = 'https://api.applink.com.bd';
  static const String applicationId = 'APP_018634';
  static const String password = '80780519b71e5be892c8bca38a039f53';

  // Send SMS via AppLink
  static Future<Map<String, dynamic>?> sendSms({
    required String message,
    required List<String> destinationAddresses,
    String sourceAddress = "77000",
  }) async {
    try {
      final url = Uri.parse('$baseUrl/sms/send');

      final data = {
        "version": "1.0",
        "applicationId": applicationId,
        "password": password,
        "message": message,
        "destinationAddresses": destinationAddresses,
        "sourceAddress": sourceAddress,
        "deliveryStatusRequest": "1",
        "encoding": "0"
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json;charset=utf-8'},
        body: jsonEncode(data),
      );

      print('Send SMS Response (${response.statusCode}): ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      print('Send SMS error: $e');
      return null;
    }
  }

  // Subscribe or unsubscribe user
  static Future<Map<String, dynamic>?> subscribeUser(
      String phoneNumber, {
        bool subscribe = true,
      }) async {
    try {
      final url = Uri.parse('$baseUrl/subscription/userSubscription');

      final data = {
        "applicationId": applicationId,
        "password": password,
        "subscriberId": phoneNumber,
        "action": subscribe ? "1" : "0",
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json;charset=utf-8'},
        body: jsonEncode(data),
      );

      print(
          'Subscription Response (${response.statusCode}): ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      print('Subscription error: $e');
      return null;
    }
  }

  // Check base size (total subscribers)
  static Future<Map<String, dynamic>?> getBaseSize() async {
    try {
      final url = Uri.parse('$baseUrl/subscription/baseSize');

      final data = {
        "applicationId": applicationId,
        "password": password,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json;charset=utf-8'},
        body: jsonEncode(data),
      );

      print('Base Size Response (${response.statusCode}): ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      print('Base size error: $e');
      return null;
    }
  }
}
