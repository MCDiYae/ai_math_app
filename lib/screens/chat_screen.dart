import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final chatProvider = context.read<ChatProvider>();
    _controller.clear();

    try {
      await chatProvider.sendMessage(text);
      _scrollToTop();
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Chat History'),
          content: const Text(
            'Are you sure you want to clear all chat messages? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<ChatProvider>().clearChat();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Chat cleared'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Clear All'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Clear chat',
            onPressed: _showClearAllDialog,
          ),
          Consumer<ChatProvider>(
            builder: (context, chatProvider, child) {
              return IconButton(
                icon: Icon(
                  chatProvider.apiConnected
                      ? Icons.done
                      : Icons.contact_support_rounded,
                ),
                tooltip: chatProvider.apiConnected
                    ? 'API Connected'
                    : 'API Disconnected',
                onPressed: () {},
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessagesList()),
          _buildLoadingIndicator(),
          _buildInputSection(),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        return ListView.builder(
          controller: _scrollController,
          reverse: true,
          itemCount: chatProvider.messages.length,
          padding: const EdgeInsets.only(bottom: 8),
          itemBuilder: (context, index) {
            final message = chatProvider.messages[index];
            return ChatBubble(message: message);
          },
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        return chatProvider.isLoading
            ? const LinearProgressIndicator(minHeight: 2)
            : const SizedBox.shrink();
      },
    );
  }

  Widget _buildInputSection() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                return IconButton(
                  icon: const Icon(Icons.send, color: Colors.white),
                  onPressed: chatProvider.isLoading ? null : _sendMessage,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
