import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String userInitial;

  const ChatScreen({super.key, required this.userName, required this.userInitial});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {"text": "Hey! 👋", "time": "7:12 PM", "isSentByMe": false},
    {"text": "Hey, how was your day?", "time": "7:20 PM", "isSentByMe": true},
    {"text": "Honestly... exhausting 😭", "time": "7:22 PM", "isSentByMe": false},
    {"text": "I get that. Want to talk more about it?", "time": "7:24 PM", "isSentByMe": true},
  ];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return; 

    final now = DateTime.now();
    final timeString = "${now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour)}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";

    setState(() {
      _messages.add({
        "text": text,
        "time": timeString,
        "isSentByMe": true,
      });
    });

    _messageController.clear(); 

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // This is the new function that shows the profile when the header is tapped
  void _showUserProfile() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111827),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white.withOpacity(0.1),
                child: Text(widget.userInitial, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              Text(widget.userName, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text("Shared Interests", style: TextStyle(color: Color(0xFFEC4899), fontSize: 16)), 
              const SizedBox(height: 24),
              const Text(
                "Bio: Just looking for a safe space to share thoughts. No advice needed, just hoping to connect with people who get it.", 
                textAlign: TextAlign.center, 
                style: TextStyle(color: Colors.white70, height: 1.5)
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        elevation: 1,
        shadowColor: Colors.white12,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        // The title is now fully wrapped in a GestureDetector to make it clickable
        title: GestureDetector(
          onTap: _showUserProfile,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white.withOpacity(0.1),
                child: Text(widget.userInitial, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.userName, style: const TextStyle(color: Colors.white, fontSize: 16)),
                  const Text("Online", style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            color: const Color(0xFF111827),
            onSelected: (value) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$value action triggered", style: const TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF8B5CF6)));
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'Mute', child: Text('Mute Notifications', style: TextStyle(color: Colors.white))),
              const PopupMenuItem(value: 'Report', child: Text('Report User', style: TextStyle(color: Colors.white))),
              const PopupMenuItem(value: 'Block', child: Text('Block User', style: TextStyle(color: Colors.redAccent))),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(24.0),
                itemCount: _messages.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(bottom: 24.0),
                      child: Center(child: Text("Today", style: TextStyle(color: Colors.white38, fontSize: 12))),
                    );
                  }
                  final msg = _messages[index - 1];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildMessageBubble(msg["text"], msg["time"], msg["isSentByMe"]),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF111827),
                border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: TextField(
                        controller: _messageController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Type a message...",
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                          icon: Icon(Icons.attachment, color: Colors.white54, size: 20),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF8B5CF6),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 18),
                      onPressed: _sendMessage,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(String text, String time, bool isSentByMe) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSentByMe ? const Color(0xFF8B5CF6) : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isSentByMe ? 16 : 4),
                bottomRight: Radius.circular(isSentByMe ? 4 : 16),
              ),
              border: isSentByMe ? null : Border.all(color: Colors.white12),
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.3),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }
}