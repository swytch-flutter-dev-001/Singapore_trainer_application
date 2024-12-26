import 'package:flutter/material.dart';

class AdminAddNotification extends StatefulWidget {
  const AdminAddNotification({super.key});

  @override
  State<AdminAddNotification> createState() => _AdminAddNotificationState();
}

class _AdminAddNotificationState extends State<AdminAddNotification> {
  final TextEditingController matterCtrl = TextEditingController();
  final TextEditingController contentCtrl = TextEditingController();

  @override
  void dispose() {
    matterCtrl.dispose();
    contentCtrl.dispose();
    super.dispose();
  }

  void clearFields(String target) {
    matterCtrl.clear();
    contentCtrl.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Notification sent to $target successfully!"),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF92C287), // Medium Green
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light background for contrast
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF659F62), // Dark Green
        title: const Text(
          "ADD NOTIFICATION",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Input
            const Text(
              "Enter Matter:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF659F62)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: matterCtrl,
              decoration: InputDecoration(
                hintText: "Notification title",
                filled: true,
                fillColor: const Color(0xFFF0F8F5), // Light Green
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF92C287)), // Medium Green border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF92C287)),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Content Input
            const Text(
              "Enter Content:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF659F62)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentCtrl,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: "Notification content",
                filled: true,
                fillColor: const Color(0xFFF0F8F5), // Light Green
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF92C287)), // Medium Green border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF92C287)),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Audience Selection Buttons
            const Text(
              "Send To:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF659F62)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Trainers Button
                ElevatedButton.icon(
                  onPressed: () {
                    clearFields("Trainers");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF659F62), // Dark Green
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.group, color: Colors.white),
                  label: const Text(
                    "Trainers",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),

                // Learners Button
                ElevatedButton.icon(
                  onPressed: () {
                    clearFields("Learners");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF659F62), // Dark Green
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.school, color: Colors.white),
                  label: const Text(
                    "Learners",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
