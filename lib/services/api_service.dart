import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {
  static const String _apiKey = "sk-9e488a8cb4294d94964d2b0ace418921";
  static const String _apiUrl = "https://api.deepseek.com/chat/completions";
  static const Duration _timeout = Duration(seconds: 30);

  Future<String> sendMessage(String message) async {
    try {
      debugPrint('>>> Sending: "$message" to $_apiUrl');

      final response = await http
          .post(
            Uri.parse(_apiUrl),
            headers: {
              "Authorization": "Bearer $_apiKey",
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "model": "deepseek-chat",
              "messages": [
                {"role": "user", "content": message},
              ],
              "temperature": 0.7,
              "max_tokens": 1000,
            }),
          )
          .timeout(_timeout);

      debugPrint('<<< Received: ${response.statusCode}');
      // Add response body check
      if (response.body.isEmpty) {
        throw ApiException('Empty response', 'Server returned empty response');
      }

      debugPrint('Response body length: ${response.body.length}');

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);

          // Add null checks
          if (data['choices'] == null || data['choices'].isEmpty) {
            throw ApiException('Invalid response', 'No choices in response');
          }

          if (data['choices'][0]['message'] == null) {
            throw ApiException('Invalid response', 'No message in choice');
          }

          return data['choices'][0]['message']['content'] ??
              'No content received';
        } catch (jsonError) {
          debugPrint('JSON parsing error: $jsonError');
          debugPrint('Response body: ${response.body}');
          throw ApiException(
            'Parsing Error',
            'Failed to parse response: $jsonError',
          );
        }
      } else {
        throw ApiException('API Error: ${response.statusCode}', response.body);
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
