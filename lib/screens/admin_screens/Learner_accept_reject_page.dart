import 'package:flutter/material.dart';
import 'package:singapore_trainer_app/utils/models.dart';

class AcceptReject extends StatelessWidget {
  const AcceptReject({super.key});

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
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("assets/images/person.png"),
              ),
              SizedBox(height: 10),
              Text(
                "Arnold",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Standard text color
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  _buildDetailRow("Category", "Swimming"),
                  SizedBox(height: 10),
                  _buildDetailRow("Place", "America"),
                  SizedBox(height: 10),
                  _buildDetailRow("Date", "12/12/2024"),
                  SizedBox(height: 10),
                  _buildDetailRow("Time", "10:00 AM"),
                ],
              ),
              SizedBox(height: 30),
              Container(
                width: 150,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green, // Standard green color for the button
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
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
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black, // Default black text color
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black, // Default black text color
            ),
          ),
        ],
      ),
    );
  }
}
