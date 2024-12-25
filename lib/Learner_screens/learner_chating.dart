import 'package:flutter/material.dart';

class ChatingLearner extends StatefulWidget {
  const ChatingLearner({super.key});

  @override
  State<ChatingLearner> createState() => _ChatingLearnerState();
}

class _ChatingLearnerState extends State<ChatingLearner> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _messageController = TextEditingController();

  // Colors
  final Color primaryColor = const Color(0xFF659F62);
  final Color secondaryColor = const Color(0xFF92C287);
  final Color backgroundColor = const Color(0xFFF0F8F5);

  // Send message function
  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          "sender": "Learner",
          "recipient": _selectedRecipient,
          "text": _messageController.text.trim(),
        });
      });
      _messageController.clear();
    }
  }

  // Chat recipient selector
  String _selectedRecipient = "ADMIN";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "CHAT WITH $_selectedRecipient",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        backgroundColor: primaryColor,
        actions: [
          // Optionally, you could add a profile icon or other features here
          Padding(
            padding: const EdgeInsets.only(right: 22),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.account_circle, color: primaryColor),
                onPressed: () {
                  // Profile or settings navigation here
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat recipient toggle
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRecipient = "ADMIN";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedRecipient == "ADMIN" ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Chat with Admin",
                      style: TextStyle(
                        color: _selectedRecipient == "ADMIN" ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedRecipient = "TRAINER";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedRecipient == "TRAINER" ? primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Chat with Trainer",
                      style: TextStyle(
                        color: _selectedRecipient == "TRAINER" ? Colors.white : primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Chat messages
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message['sender'] == "Learner";

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isMe ? primaryColor : secondaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isMe ? 12 : 0),
                        topRight: Radius.circular(isMe ? 0 : 12),
                        bottomLeft: const Radius.circular(12),
                        bottomRight: const Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      message['text'] ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: isMe ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Input area
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _sendMessage,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: primaryColor,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
