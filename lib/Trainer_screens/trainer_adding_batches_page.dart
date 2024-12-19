import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BatchDetailPage extends StatelessWidget {
  final Map<String, dynamic> batchDetails;

  BatchDetailPage({required this.batchDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(batchDetails['batchName'] ?? 'No Batch Name',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.white),),
        backgroundColor: Color(0xFF659F62), // Dark Green
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Batch Details',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF659F62),
                ),
              ),
              SizedBox(height: 20.h),

              // Batch Name
              _buildDetailCard(
                'Batch Name:',
                batchDetails['batchName'] ?? 'No Batch Name',
              ),
              SizedBox(height: 15.h),

              // Days
              _buildDetailCard(
                'Days:',
                batchDetails['days'] ?? 'No Days Specified',
              ),
              SizedBox(height: 15.h),

              // Time Slot
              _buildDetailCard(
                'Time Slot:',
                batchDetails['timeSlot'] ?? 'No Time Slot',
              ),
              SizedBox(height: 15.h),

              // Max Capacity
              _buildDetailCard(
                'Max Capacity:',
                batchDetails['maxCapacity']?.toString() ?? '0',
              ),
              SizedBox(height: 15.h),

              // Enrolled Learners
              _buildDetailCard(
                'Enrolled Learners:',
                batchDetails['enrolledLearners']?.toString() ?? '0',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to create a reusable card for batch details
  Widget _buildDetailCard(String title, String value) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      color: Color(0xFFF1F8E9), // Light Green background for the card
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Color(0xFF659F62),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 16.sp,
                color: Color(0xFF92C287), // Medium Green
              ),
            ),
          ],
        ),
      ),
    );
  }
}
