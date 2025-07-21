import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


class AIService {
  static const String _apiKey = "sk-6ecae3ba03614f4280a6a94097fdaa7b";
  static const String _apiUrl = "https://api.deepseek.com/chat/completions";

  Future<String> sendMessage(String message) async {
    try {
      // First check if we can resolve the host
      await InternetAddress.lookup('api.deepseek.com');
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          "Authorization": "Bearer $_apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "deepseek-chat",
          "messages": [
            {"role": "user", "content": message}
          ],
        }),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        throw "API Error: ${response.statusCode} - ${response.body}";
      }
    } on SocketException catch (e) {
      throw "Network error: ${e.message}";
    } on HttpException catch (e) {
      throw "HTTP error: ${e.message}";
    } on TimeoutException {
      throw "Request timed out";
    } catch (e) {
      throw "Connection failed: ${e.toString()}";
    }
  }
}