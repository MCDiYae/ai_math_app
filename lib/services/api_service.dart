import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {
  static const String _apiKey = "sk-6ecae3ba03614f4280a6a94097fdaa7b";
  static const String _apiUrl = "https://api.deepseek.com/chat/completions";
  static const Duration _timeout = Duration(seconds: 30);

  Future<String> sendMessage(String message) async {
    try {
      debugPrint('>>> Sending: "$message" to $_apiUrl');
      
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          "Authorization": "Bearer $_apiKey",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "model": "deepseek-chat",
          "messages": [{"role": "user", "content": message}],
          "temperature": 0.7,
          "max_tokens": 1000,
        }),
      ).timeout(_timeout);

      debugPrint('<<< Received: ${response.statusCode}');
      debugPrint('Response: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        throw ApiException(
          'API Error: ${response.statusCode}',
          response.body,
        );
      }
    } on TimeoutException {
      throw ApiException('Request timed out', 'Please try again.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Network Error', e.toString());
    }
  }
}

class ApiException implements Exception {
  final String title;
  final String message;

  ApiException(this.title, this.message);

  @override
  String toString() => '$title: $message';
}