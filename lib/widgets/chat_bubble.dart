import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.isUser;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) _buildAvatar(theme, isUser),
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(12),
              decoration: _buildBubbleDecoration(theme, isUser),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isUser ? Colors.black87 : Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('HH:mm').format(message.timestamp),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) _buildAvatar(theme, isUser),
        ],
      ),
    );
  }

  Widget _buildAvatar(ThemeData theme, bool isUser) {
    return CircleAvatar(
      backgroundColor: theme.primaryColor.withValues(alpha: 0.2),
      radius: 16,
      child: Icon(
        isUser ? Icons.person : Icons.auto_awesome,
        size: 14,
        color: isUser ? theme.primaryColor : null,
      ),
    );
  }

  BoxDecoration _buildBubbleDecoration(ThemeData theme, bool isUser) {
    return BoxDecoration(
      color: isUser
          ? theme.primaryColor.withValues(alpha: 0.1)
          : Colors.grey[100],
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(16),
        topRight: const Radius.circular(16),
        bottomLeft: Radius.circular(isUser ? 16 : 0),
        bottomRight: Radius.circular(isUser ? 0 : 16),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}