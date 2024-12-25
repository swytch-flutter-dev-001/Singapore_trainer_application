import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive design
import 'package:intl/intl.dart'; // To format the time

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
        String timestamp = DateFormat('hh:mm a').format(DateTime.now());
        _messages.add({
          "sender": "Trainer",
          "text": _messageController.text.trim(),
          "status": "pending", // Message is pending when first sent
          "time": timestamp,
        });
      });

      // Wait for 3 seconds and then update the message status
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _messages[_messages.length - 1]['status'] = "delivered"; // Set status to delivered
        });
      });

      _messageController.clear();
    }
  }

  // Show options when long press on a message
  void _showDeleteOptions(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Delete Message", style: TextStyle(color: Colors.black, fontSize: 16.sp)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Delete for Me", style: TextStyle(color: Colors.black)),
                onTap: () {
                  setState(() {
                    _messages.removeAt(index);
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Delete for Everyone", style: TextStyle(color: Colors.black)),
                onTap: () {
                  setState(() {
                    _messages[index]['text'] = "This message has been deleted for everyone";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Clear Chat", style: TextStyle(color: Colors.black)),
                onTap: () {
                  setState(() {
                    _messages.clear();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 80, // Responsive height
        backgroundColor: primaryColor,
        title: Text(
          "Chat",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
            fontSize: 18.sp,
            letterSpacing: 1.2,
          ),
        ),
        elevation: 5,
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message['sender'] == "Trainer";
                final status = message['status'] ?? "pending";

                return GestureDetector(
                  onLongPress: () => _showDeleteOptions(index),
                  child: Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: isMe ? primaryColor : secondaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(isMe ? 12.r : 0),
                          topRight: Radius.circular(isMe ? 0 : 12.r),
                          bottomLeft: Radius.circular(12.r),
                          bottomRight: Radius.circular(12.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(2, 3), // Shadow direction
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['text'] ?? '',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isMe ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                message['time'] ?? '',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isMe ? Colors.white70 : Colors.black54,
                                ),
                              ),
                              if (status == "pending")
                                CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              if (status == "delivered")
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Input area
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                    ),
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: _sendMessage,
                  child: CircleAvatar(
                    radius: 28.r,
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 24.sp,
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
