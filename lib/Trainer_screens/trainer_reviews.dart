import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:singapore_trainer_app/Trainer_screens/trainer_response_page.dart';

class TrainerReviews extends StatefulWidget {
  const TrainerReviews({super.key});

  @override
  State<TrainerReviews> createState() => _TrainerReviewsState();
}

class _TrainerReviewsState extends State<TrainerReviews> {
  final List<Map<String, dynamic>> _reviews = [
    {"learner": "Alice", "review": "Great experience!", "rating": 9.6, "date": DateTime(2023, 12, 1), "response": null},
    {"learner": "Bob", "review": "Good but can improve.", "rating": 8.4, "date": DateTime(2023, 11, 28), "response": null},
    {"learner": "Charlie", "review": "Exceptional class!", "rating": 9.8, "date": DateTime(2023, 12, 3), "response": null},
    {"learner": "Daisy", "review": "Average experience.", "rating": 7.5, "date": DateTime(2023, 11, 20), "response": null},
  ];

  String _sortBy = "Newest"; // Default sorting type

  List<Map<String, dynamic>> get _filteredReviews {
    List<Map<String, dynamic>> filtered = List.from(_reviews);

    // Sorting logic
    if (_sortBy == "Newest") {
      filtered.sort((a, b) => b["date"].compareTo(a["date"]));
    } else if (_sortBy == "Oldest") {
      filtered.sort((a, b) => a["date"].compareTo(b["date"]));
    } else if (_sortBy == "Highest Rating") {
      filtered.sort((a, b) => b["rating"].compareTo(a["rating"]));
    }

    return filtered;
  }

  void _updateFilter(String filter) {
    setState(() {
      _sortBy = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 70.h,
        backgroundColor: const Color(0xFF659F62),
        title: const Text(
          "REVIEWS",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Custom Animated Filter Chips with Hover Effect
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAnimatedFilterButton("Newest"),
                const SizedBox(width: 10),
                _buildAnimatedFilterButton("Oldest"),
                const SizedBox(width: 10),
                _buildAnimatedFilterButton("Highest Rating"),
              ],
            ),
          ),
          // const Divider(height: 1, color: Colors.grey),

          // ListView for Filtered Reviews
          Expanded(
            child: ListView.builder(
              itemCount: _filteredReviews.length,
              itemBuilder: (context, index) {
                final review = _filteredReviews[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F8F5), // Light green background
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Learner Name and Date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            review["learner"],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          Text(
                            "${review["date"].day}/${review["date"].month}/${review["date"].year}",
                            style: const TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),

                      // Review Text
                      Text(
                        review["review"],
                        style: const TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      const SizedBox(height: 10),

                      // Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(
                            review["rating"].toStringAsFixed(1),
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ],
                      ),

                      // Response Button
                      if (review["response"] == null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReviewResponsePage(
                                    review: review,
                                    onSubmitResponse: (response) {
                                      setState(() {
                                        review["response"] = response;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                            icon: const FaIcon(Icons.reply,color: Color(0xFF659F62),),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Response: ${review['response']}",
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build animated filter chips
  Widget _buildAnimatedFilterButton(String label) {
    bool isActive = _sortBy == label;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
        boxShadow: isActive
            ? [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ]
            : [],
      ),
      child: GestureDetector(
        onTap: () => _updateFilter(label),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
