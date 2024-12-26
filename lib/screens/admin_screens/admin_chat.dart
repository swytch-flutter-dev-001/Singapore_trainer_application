import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminChat extends StatefulWidget {
  const AdminChat({super.key});

  @override
  State<AdminChat> createState() => _AdminChatState();
}

class _AdminChatState extends State<AdminChat> {
  List<Map<String, dynamic>> messages = [];
  int onlineCount = 8;
  TextEditingController _messageController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void sendMessage(String sender, String message) {
    if (message.trim().isNotEmpty) {
      setState(() {
        messages.add({
          "sender": sender,
          "message": message,
          "time": TimeOfDay.now().format(context),
          "isDeleted": false,
          "type": "text",
          "status": "sending", // Initially set to "sending"
        });
      });
      _messageController.clear();

      // Simulate a 3-second delay before marking the message as "sent"
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          messages.last["status"] = "sent";
        });
      });
    }
  }

  void sendImage(File image) {
    setState(() {
      messages.add({
        "sender": "Admin",
        "message": image.path,
        "time": TimeOfDay.now().format(context),
        "isDeleted": false,
        "type": "image",
        "status": "sending",
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        messages.last["status"] = "sent";
      });
    });
  }

  void sendDocument(File document) {
    setState(() {
      messages.add({
        "sender": "Admin",
        "message": document.path,
        "time": TimeOfDay.now().format(context),
        "isDeleted": false,
        "type": "document",
        "status": "sending",
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        messages.last["status"] = "sent";
      });
    });
  }

  void sendLocation(String location) {
    setState(() {
      messages.add({
        "sender": "Admin",
        "message": location,
        "time": TimeOfDay.now().format(context),
        "isDeleted": false,
        "type": "location",
        "status": "sending",
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        messages.last["status"] = "sent";
      });
    });
  }

  void sendContact(String contact) {
    setState(() {
      messages.add({
        "sender": "Admin",
        "message": contact,
        "time": TimeOfDay.now().format(context),
        "isDeleted": false,
        "type": "contact",
        "status": "sending",
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        messages.last["status"] = "sent";
      });
    });
  }

  void sendPoll(String poll) {
    setState(() {
      messages.add({
        "sender": "Admin",
        "message": poll,
        "time": TimeOfDay.now().format(context),
        "isDeleted": false,
        "type": "poll",
        "status": "sending",
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        messages.last["status"] = "sent";
      });
    });
  }

  void sendEvent(String event) {
    setState(() {
      messages.add({
        "sender": "Admin",
        "message": event,
        "time": TimeOfDay.now().format(context),
        "isDeleted": false,
        "type": "event",
        "status": "sending",
      });
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        messages.last["status"] = "sent";
      });
    });
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      sendImage(File(pickedFile.path));
    }
  }

  Future<void> pickDocument() async {
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery); // Placeholder for document picker
    if (pickedFile != null) {
      sendDocument(File(pickedFile.path));
    }
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Gallery"),
              onTap: () {
                pickImage();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.insert_drive_file),
              title: Text("Document"),
              onTap: () {
                pickDocument();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Location"),
              onTap: () {
                sendLocation("Sample Location");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("Contact"),
              onTap: () {
                sendContact("Sample Contact");
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete for Me"),
              onTap: () {
                setState(() {
                  messages[index]["isDeleted"] = true;
                  // Optionally show a "deleted" message for yourself
                  messages[index]["message"] = "This message was deleted";
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_forever),
              title: Text("Delete for Everyone"),
              onTap: () {
                setState(() {
                  // Change message text for everyone
                  messages[index]["message"] = "This message was deleted";
                  messages[index]["isDeleted"] = true;  // Mark as deleted
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.clear_all),
              title: Text("Clear Chat"),
              onTap: () {
                setState(() {
                  messages.clear();
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F8F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80.h,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF659F62),
        
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage("assets/images/Singapore Trainers-2.png"),
              radius: 30.r,
            ),
            SizedBox(
              width: 10.h,
            ),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                Text(
                  "CHANNEL CHAT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "$onlineCount Members Online",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isAdmin = message["sender"] == "Admin";

                return GestureDetector(
                  onLongPress: () => _showDeleteOptions(index), // Long press to show options
                  child: Align(
                    alignment: isAdmin ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: isAdmin ? Color(0xFF92C287) : Colors.grey[300],
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message["sender"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: isAdmin ? Colors.green[800] : Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            message["message"],
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  message["time"],
                                  style: TextStyle(fontSize: 12.sp, color: Colors.black54),
                                ),
                                SizedBox(width: 5.w),
                                Icon(
                                  message["status"] == "sending" ? Icons.access_time : Icons.done_all,
                                  size: 16.sp,
                                  color: message["status"] == "sending" ? Colors.grey : Colors.green,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.attach_file),
                    onPressed: _showAttachmentOptions,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Color(0xFF659F62)),
                    onPressed: () => sendMessage("Admin", _messageController.text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
