import 'package:flutter/material.dart';

class AdminChat extends StatefulWidget {
  const AdminChat({super.key});

  @override
  State<AdminChat> createState() => _AdminChatState();
}

class _AdminChatState extends State<AdminChat> {
  List<Map<String, dynamic>> messages = [];
  int onlineCount = 8; // Example number of online members
  TextEditingController _messageController = TextEditingController();

  void sendMessage(String sender, String message) {
    if (message.trim().isNotEmpty) {
      setState(() {
        messages.add({
          "sender": sender,
          "message": message,
          "time": TimeOfDay.now().format(context),
        });
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: IconThemeData(
          color: Colors.white
        ),

        backgroundColor: Color(0xFF659F62), // Dark Green
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("CHANNEL CHAT",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
            Text(
              "$onlineCount Members Online",
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isAdmin = message["sender"] == "Admin";

                return Align(
                  alignment:
                  isAdmin ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isAdmin
                          ? Color(0xFFF0F8F5)
                          : Colors.grey[300], // Color based on sender
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message["sender"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isAdmin
                                ? Colors.green[800]
                                : Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(message["message"]),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            message["time"],
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border(
                top: BorderSide(color: Colors.grey[400]!),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xFF659F62)),
                  onPressed: () {
                    sendMessage("Admin", _messageController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
