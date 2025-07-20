import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/chat_message.dart';

class AIService {
  static const String _baseUrl = 'https://api.deepseek.com/v1/chat/completions';
  final String? _apiKey = "6c0438ad49a4438bb348bbb5a182fd1a";

  Future<String> sendMessage(List<ChatMessage> messages) async {
    if (_apiKey == null) throw Exception('API key not found');

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'deepseek-math',
        'messages': messages.map((m) => {
          'role': m.isUser ? 'user' : 'assistant',
          'content': m.text
        }).toList(),
        'temperature': 0.7,
        'max_tokens': 500,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to get response: ${response.statusCode}');
    }
  }
}