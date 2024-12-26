import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';  // Import the SpinKit package

class ReviewResponsePage extends StatefulWidget {
  final Map<String, dynamic> review;
  final Function(String) onSubmitResponse;

  const ReviewResponsePage({required this.review, required this.onSubmitResponse, super.key});

  @override
  State<ReviewResponsePage> createState() => _ReviewResponsePageState();
}

class _ReviewResponsePageState extends State<ReviewResponsePage> {
  TextEditingController _responseController = TextEditingController();
  bool isLoading = false;  // This will track the loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        title: const Text(
          'RESPOND TO REVIEW',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF659F62), // Dark Green
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Review Info
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFCDEAC0), // Light Green
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Review from ${widget.review['learner']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '${widget.review['date'].day}/${widget.review['date'].month}/${widget.review['date'].year}',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Review Content
            Text(
              widget.review['review'],
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),

            // Response Section
            const Text(
              'Your Response:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _responseController,
              maxLines: 6,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Write your response here...',
                hintStyle: const TextStyle(color: Colors.black45),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF659F62)), // Dark Green
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF659F62)), // Dark Green
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),

            // Submit Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: isLoading ? null : () async {
                  setState(() {
                    isLoading = true;  // Show the loading spinner
                  });

                  // Simulate a network request or some action before submitting the response
                  await Future.delayed(Duration(seconds: 2));  // Simulate a delay

                  widget.onSubmitResponse(_responseController.text);  // Submit the response
                  Navigator.pop(context);  // Go back to the previous screen

                  setState(() {
                    isLoading = false;  // Hide the loading spinner after submission
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF659F62), // Dark Green
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isLoading
                    ? SpinKitFadingCube(color: Colors.white, size: 30.sp)  // Show spinner when loading
                    : const Text(
                  'Submit Response',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
