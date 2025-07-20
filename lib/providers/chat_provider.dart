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
    // Add user message immediately
    _addMessage(text, true);
    
    try {
      _isLoading = true;
      _error = null; // Clear previous errors
      notifyListeners();
      
      // Get AI response
      final response = await _aiService.sendMessage(_messages);
      
      // Add AI response
      _addMessage(response, false);
    } catch (e) {
      _error = e.toString();
      
      // Add error message to chat for better UX
      _addMessage("Sorry, I couldn't process your request. Please try again.", false);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _addMessage(String text, bool isUser) {
    _messages.insert(0, ChatMessage(
      text: text,
      isUser: isUser,
    ));
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    _error = null; // Clear any existing errors
    notifyListeners();
  }
}