import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiAPI {
  // Use your amplifyv2 key directly (temporary - see security note below)
  static const String _apiKey = 'key';
  static const String _url = "https://api.groq.com/openai/v1/chat/completions";

  static Future<String> generate(String prompt) async {
    try {
      print("⚡ Calling Groq API...");

      final response = await http.post(
        Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          "model": "llama-3.3-70b-versatile",
          "messages": [
            {
              "role": "user",
              "content": prompt
            }
          ],
          "temperature": 0.7,
          "max_tokens": 4000,
        }),
      ).timeout(const Duration(seconds: 30));

      print("Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['choices'][0]['message']['content'];
        print("✅ Success: Generated ${text.length} characters");
        return text;
      } else {
        final error = jsonDecode(response.body);
        final errorMessage = error['error']?['message'] ?? 'Unknown error';
        print("❌ API Error: $errorMessage");
        throw Exception("API Error: $errorMessage");
      }
    } on http.ClientException catch (e) {
      print("❌ Network error: $e");
      throw Exception("Network error: Please check your internet connection");
    } on FormatException catch (e) {
      print("❌ Format error: $e");
      throw Exception("Invalid response format from API");
    } catch (e) {
      print("❌ Error: $e");

      if (e.toString().contains("SocketException")) {
        throw Exception("Network error: Cannot reach the server");
      } else if (e.toString().contains("TimeoutException") || e.toString().contains("timeout")) {
        throw Exception("Request timeout: Please try again");
      } else {
        rethrow;
      }
    }
  }
}
