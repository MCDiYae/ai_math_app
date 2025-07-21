import 'package:flutter/material.dart';
import '../models/chat_message.dart';
import '../services/api_service.dart';

class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  bool _apiConnected = true;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;
  bool get apiConnected => _apiConnected;

  ChatProvider() {
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    _messages.insert(0, ChatMessage(
      text: "Hello! I'm your AI assistant. How can I help you today?",
      isUser: false,
      timestamp: DateTime.now(),
    ));
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || _isLoading) return;

    // Add user message
    _messages.insert(0, ChatMessage(
      text: text.trim(),
      isUser: true,
      timestamp: DateTime.now(),
    ));

    _setLoading(true);

    try {
      final aiResponse = await _apiService.sendMessage(text.trim());
      
      // Add AI response
      _messages.insert(0, ChatMessage(
        text: aiResponse,
        isUser: false,
        timestamp: DateTime.now(),
      ));
      
      _setApiConnected(true);
    } catch (e) {
      _setApiConnected(false);
      rethrow; // Re-throw to handle in UI
    } finally {
      _setLoading(false);
    }
  }

  void clearChat() {
    _messages.clear();
    _addWelcomeMessage();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setApiConnected(bool connected) {
    _apiConnected = connected;
    notifyListeners();
  }
}