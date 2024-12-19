import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'class_detail_page.dart';

class DETAILS extends StatefulWidget {
  const DETAILS({super.key});

  @override
  State<DETAILS> createState() => _DETAILSState();
}

class _DETAILSState extends State<DETAILS> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _classes = [
    {
      "title": "Beginner Swimming",
      "time": "10:00 AM - 11:00 AM",
      "realPrice": 400,
      "offerPrice": 300,
      "icon": "assets/images/Singapore Trainers-2.png",
    },
    {
      "title": "Advanced Yoga",
      "time": "11:30 AM - 12:30 PM",
      "realPrice": 350,
      "offerPrice": 250,
      "icon": "assets/images/Singapore Trainers-2.png",
    },
    {
      "title": "Hip Hop Dance",
      "time": "2:00 PM - 3:00 PM",
      "realPrice": 250,
      "offerPrice": 200,
      "icon": "assets/images/Singapore Trainers-2.png",
    },
    {
      "title": "Karate Basics",
      "time": "4:00 PM - 5:00 PM",
      "realPrice": 300,
      "offerPrice": 250,
      "icon": "assets/images/Singapore Trainers-2.png",
    },
  ];

  List<Map<String, dynamic>> _filteredClasses = [];

  @override
  void initState() {
    super.initState();
    _filteredClasses = _classes;
    _searchController.addListener(_filterClasses);
  }

  // Filter function based on search query
  void _filterClasses() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredClasses = _classes.where((classItem) {
        final title = classItem['title'].toLowerCase();
        return title.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        onPressed: _showAddClassDialog,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by class title...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _filteredClasses.length,
              itemBuilder: (context, index) {
                final classItem = _filteredClasses[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClassDetailsPage(classDetails: classItem),
                      ),
                    );
                  },

                  child: Card(
                    color: const Color(0xFFF0F8F5),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            classItem["icon"],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  classItem["title"],
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(classItem["time"]),
                                const SizedBox(height: 5),
                                RatingBar.builder(
                                  initialRating: 4,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemBuilder: (context, _) =>
                                  const Icon(Icons.star, color: Colors.amber),
                                  onRatingUpdate: (rating) {},
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("\$${classItem["offerPrice"]}",
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold)),
                              Text("\$${classItem["realPrice"]}",
                                  style: const TextStyle(
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough)),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _showEditDialog(index),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Dialog to add a new class
  void _showAddClassDialog() {
    final titleController = TextEditingController();
    final timeController = TextEditingController();
    final realPriceController = TextEditingController();
    final offerPriceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          title: const Text("Add Class"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(titleController, "Class Title"),
                _buildTextField(timeController, "Class Time"),
                _buildTextField(realPriceController, "Real Price", isNumber: true),
                _buildTextField(offerPriceController, "Offer Price", isNumber: true),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),),
            ),
            SizedBox(
              height: 40,
              width: 90,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  backgroundColor: Color(0xFF659F62),
                  foregroundColor: Colors.white
                ),
                onPressed: () {
                  setState(() {
                    _classes.add({
                      "title": titleController.text,
                      "time": timeController.text,
                      "realPrice": int.parse(realPriceController.text),
                      "offerPrice": int.parse(offerPriceController.text),
                      "icon": "assets/images/Singapore Trainers-2.png",
                    });
                  });
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              ),
            ),
          ],
        );
      },
    );
  }

  // Dialog to edit an existing class
  void _showEditDialog(int index) {
    final classItem = _filteredClasses[index];
    final titleController = TextEditingController(text: classItem["title"]);
    final timeController = TextEditingController(text: classItem["time"]);
    final realPriceController = TextEditingController(text: classItem["realPrice"].toString());
    final offerPriceController = TextEditingController(text: classItem["offerPrice"].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Class Details"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(titleController, "Class Title"),
                _buildTextField(timeController, "Class Time"),
                _buildTextField(realPriceController, "Real Price", isNumber: true),
                _buildTextField(offerPriceController, "Offer Price", isNumber: true),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel",style: TextStyle(fontWeight: FontWeight.w500),),
            ),
            SizedBox(
        height: 40,
              width: 90,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF659F62)
                ),
                onPressed: () {
                  setState(() {
                    _filteredClasses[index]["title"] = titleController.text;
                    _filteredClasses[index]["time"] = timeController.text;
                    _filteredClasses[index]["realPrice"] = int.parse(realPriceController.text);
                    _filteredClasses[index]["offerPrice"] = int.parse(offerPriceController.text);
                  });
                  Navigator.pop(context);
                },
                child: const Text("Save",style: TextStyle(fontWeight: FontWeight.w500),),
              ),
            ),
          ],
        );
      },
    );
  }

  // Helper function for text fields
  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF0F8F5)),
        ),
      ),
    );
  }
}
