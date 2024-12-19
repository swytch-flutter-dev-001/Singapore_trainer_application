import 'package:flutter/material.dart';

class TrainerAcceptReject extends StatefulWidget {
  const TrainerAcceptReject({super.key});

  @override
  State<TrainerAcceptReject> createState() => _TrainerAcceptRejectState();
}

class _TrainerAcceptRejectState extends State<TrainerAcceptReject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 330,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200, // Light background color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/person.png"),
                backgroundColor: Colors.grey,
              ),
              const SizedBox(height: 10),
              const Text(
                "Arnold",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Standard text color
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  _buildDetailRow("Category", "Swimming"),
                  const SizedBox(height: 10),
                  _buildDetailRow("Position", "Trainer"),
                  const SizedBox(height: 10),
                  _buildDetailRow("Place", "America"),
                  const SizedBox(height: 10),
                  _buildDetailRow("Date", "12/12/2024"),
                  const SizedBox(height: 10),
                  _buildDetailRow("Time", "10:00 AM"),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                width: 150,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green, // Standard green color for the button
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Accepted",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for contrast
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black, // Default black text color
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Default black text color
            ),
          ),
        ],
      ),
    );
  }
}
