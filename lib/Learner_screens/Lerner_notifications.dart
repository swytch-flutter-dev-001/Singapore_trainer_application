import 'package:flutter/material.dart';

class LearnerNotificationPage extends StatefulWidget {
  const LearnerNotificationPage({super.key});

  @override
  State<LearnerNotificationPage> createState() =>
      _LearnerNotificationPageState();
}

class _LearnerNotificationPageState extends State<LearnerNotificationPage> {
  // Static list of notifications from the admin for demonstration
  final List<Map<String, String>> _adminNotifications = [
    {
      "matter": "New Learning Material",
      "content": "New materials for your next session have been uploaded.",
    },
    {
      "matter": "Schedule Update",
      "content": "Your swimming session on December 15th has been rescheduled to 5 PM.",
    },
    {
      "matter": "Holiday Notice",
      "content": "The center will remain closed on January 1st for New Year celebrations.",
    },
    {
      "matter": "Exam Reminder",
      "content": "Don't forget about the upcoming assessment on December 20th.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        toolbarHeight: 80,
        backgroundColor: const Color(0xFF659F62), // Theme color
        title: const Text(
          "NOTIFICATIONS",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),
        ),

      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10.0),
        itemCount: _adminNotifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final notification = _adminNotifications[index];
          return Card(
            color: const Color(0xFFF0F8F5), // Theme-based card color
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              leading: CircleAvatar(
                backgroundColor: Colors.white.withOpacity(0.2),
                child: const Icon(
                  Icons.admin_panel_settings,
                  color: Colors.black,
                ),
              ),
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
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Message: ${notification["matter"]}'),
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
