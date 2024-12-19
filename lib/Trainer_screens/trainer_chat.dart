import 'package:flutter/material.dart';

class ChatingTrainer extends StatefulWidget {
  const ChatingTrainer({super.key});

  @override
  State<ChatingTrainer> createState() => _ChatingTrainerState();
}

class _ChatingTrainerState extends State<ChatingTrainer> {
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
          "sender": "Trainer",
          "text": _messageController.text.trim(),
        });
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        toolbarHeight: 80,
        backgroundColor: Color(0xFF659F62),
        title: Text("CHAT PAGE",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white,fontSize: 18),),
      ),
     
      backgroundColor: backgroundColor,
      body: Column(
        children: [
         
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message['sender'] == "Trainer";

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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: primaryColor,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
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
