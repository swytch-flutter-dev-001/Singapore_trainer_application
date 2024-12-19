import 'package:flutter/material.dart';

class InsightPage extends StatelessWidget {
  const InsightPage({super.key});

  // Define maximum values for scaling the bars dynamically
  final double maxTrainers = 50;
  final double maxLearners = 200;
  final double maxClasses = 100;
  final double maxApprovals = 20;
  final double maxSessions = 50;
  final double maxFeedback = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "INSIGHTS",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF659F62), // Dark Green
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionHeader("Overview"),
            _buildInsightBar("Total Trainers", 25, maxTrainers, Icons.person),
            _buildInsightBar("Total Learners", 120, maxLearners, Icons.group),
            const Divider(height: 30, color: Color(0xFF92C287)), // Medium Green

            _buildSectionHeader("Performance"),
            _buildInsightBar("Classes Conducted", 45, maxClasses, Icons.school),
            _buildInsightBar("Pending Approvals", 8, maxApprovals, Icons.pending_actions),
            const Divider(height: 30, color: Color(0xFF92C287)), // Medium Green

            _buildSectionHeader("Engagement"),
            _buildInsightBar("Active Sessions", 30, maxSessions, Icons.access_time),
            _buildInsightBar("Feedback Received", 15, maxFeedback, Icons.feedback),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF659F62), // Dark Green
        ),
      ),
    );
  }

  Widget _buildInsightBar(String title, double value, double maxValue, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color(0xFFCDEAC0), // Light Green
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFF92C287), // Medium Green
                  radius: 25,
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
                Text(
                  "${value.toInt()}",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: value / maxValue,
                minHeight: 12,
                backgroundColor: Colors.grey.shade300,
                color: const Color(0xFF659F62), // Dark Green
              ),
            ),
          ],
        ),
      ),
    );
  }
}
