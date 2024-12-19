import 'package:flutter/material.dart';

class notification_Trainer extends StatefulWidget {
  const notification_Trainer({super.key});

  @override
  State<notification_Trainer> createState() => _notification_TrainerState();
}

class _notification_TrainerState extends State<notification_Trainer> {
  // Static list of notifications for demonstration
  final List<Map<String, String>> _notifications = [
    {
      "matter": "New Session Announced",
      "content": "A new session for advanced training starts next week."
    },
    {
      "matter": "Holiday Notice",
      "content": "The center will remain closed on December 25th for Christmas."
    },
    {
      "matter": "System Maintenance",
      "content": "Scheduled maintenance on December 10th from 10 AM to 12 PM."
    },
    {
      "matter": "Feedback Reminder",
      "content": "Please provide feedback for the last training session."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: const Color(0xFF659F62),
        title: const Text(
          "NOTIFICATIONS",
          style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
        ),

        toolbarHeight: 80, // Set the AppBar height
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10.0),
        itemCount: _notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Card(
            color: const Color(0xFFF0F8F5),
            elevation: 3,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              title: Text(
                notification["matter"]!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                notification["content"]!,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected: ${notification["matter"]}'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
