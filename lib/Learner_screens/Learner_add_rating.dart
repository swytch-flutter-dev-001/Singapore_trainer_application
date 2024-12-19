import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class LearnerAddRating extends StatefulWidget {
  const LearnerAddRating({super.key});

  @override
  State<LearnerAddRating> createState() => _LearnerAddRatingState();
}

class _LearnerAddRatingState extends State<LearnerAddRating> {
  double rating = 0;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Color(0xFF659F62), // Dark Green
        title: const Text(
          "Rating and Reviews",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
          
              // Rating Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "What is your rate?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 40,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          this.rating = rating;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Please share your opinion about the class",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
          
                    // Feedback TextField
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFFCDEAC0), // Light Green
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Color(0xFF92C287)), // Medium Green
                      ),
                      child: TextFormField(
                        controller: _feedbackController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: "Your review",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
          
                    // Submit Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF659F62), // Dark Green
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(size.width, 50),
                      ),
                      onPressed: () {
                        // Handle submit
                      },
                      child: const Text(
                        "Send Review",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
