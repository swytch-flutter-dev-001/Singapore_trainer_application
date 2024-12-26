import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClassDetailsPage extends StatelessWidget {
  final Map<String, dynamic> classDetails;

  const ClassDetailsPage({super.key, required this.classDetails});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen size information
    double screenWidth = MediaQuery.of(context).size.width;
    bool isLargeScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
       toolbarHeight: 70.h,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          (classDetails['title'] ?? 'CLASS').toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF659F62),
        elevation: 3,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Color(0xFFF0F8F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        classDetails['icon'],
                        width: screenWidth * 0.3, // Dynamic image size
                        height: screenWidth * 0.3, // Dynamic image size
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      classDetails['title'],
                      style: TextStyle(
                        fontSize: isLargeScreen ? 30 : 26,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF659F62),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildDetailItem(Icons.access_time, "Time", classDetails['time']),
                  const SizedBox(height: 16),
                  _buildDetailItem(Icons.price_change, "Real Price", "\$${classDetails['realPrice']}", textColor: Colors.red, isStrikethrough: true),
                  const SizedBox(height: 8),
                  _buildDetailItem(Icons.local_offer, "Offer Price", "\$${classDetails['offerPrice']}", textColor: const Color(0xFF659F62)),
                  const SizedBox(height: 20),
                  const Text(
                    "Rating",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: isLargeScreen ? 40 : 30, // Adjust size based on screen width
                      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (rating) {
                        // Handle rating update if needed
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle purchase action
                        _showPurchaseConfirmation(context);
                      },
                      icon: const Icon(Icons.shopping_cart, color: Colors.white),
                      label: const Text("Purchase Pack"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF659F62),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value, {Color textColor = Colors.black, bool isStrikethrough = false}) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF659F62)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            "$label: ",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            color: textColor,
            decoration: isStrikethrough ? TextDecoration.lineThrough : TextDecoration.none,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showPurchaseConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Purchase Successful"),
        content: const Text("Thank you for purchasing the learning pack!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
