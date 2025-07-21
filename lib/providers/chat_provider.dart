import 'package:ai_math_app/services/api_service.dart';
import 'package:flutter/material.dart';
import '../models/chat_message.dart';

class ChatProvider with ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  String? _error;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final AIService _aiService = AIService();

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    // Add user message
    _messages.insert(0, ChatMessage(text: text, isUser: true));
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get AI response
      final response = await _aiService.sendMessage(text);
      
      // Add AI message
      _messages.insert(0, ChatMessage(text: response, isUser: false));
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  
  void clearMessages() {
    _messages.clear();
    _error = null; 
    notifyListeners();
  }


}