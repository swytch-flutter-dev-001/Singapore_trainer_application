import 'package:flutter/material.dart';
import '../utils/class_details_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class LearnerServicePage extends StatefulWidget {
  const LearnerServicePage({super.key});

  @override
  _LearnerServicePageState createState() => _LearnerServicePageState();
}

class _LearnerServicePageState extends State<LearnerServicePage> {
  final Color primaryColor = const Color(0xFF659F62); // Theme color

  // Sample list of classes with learner details, trainer names, and images
  final List<Map<String, String>> classDetails = [
    {
      "className": "Strength Training",
      "time": "Mon, Wed, Fri - 6:00 AM to 7:00 AM",
      "trainerName": "Tyson",
      "imageUrl": "https://via.placeholder.com/80?text=Strength+Training",
      "trainerImage": "https://via.placeholder.com/80?text=Tyson",
      "trainerBio": "Expert in strength and conditioning."
    },
    {
      "className": "Yoga",
      "time": "Tue, Thu - 7:00 AM to 8:00 AM",
      "trainerName": "Sophia",
      "imageUrl": "https://via.placeholder.com/80?text=Yoga",
      "trainerImage": "https://via.placeholder.com/80?text=Sophia",
      "trainerBio": "Certified yoga instructor with 5 years experience."
    },
    {
      "className": "Swimming",
      "time": "Mon, Wed - 5:00 PM to 6:00 PM",
      "trainerName": "Michael",
      "imageUrl": "https://via.placeholder.com/80?text=Swimming",
      "trainerImage": "https://via.placeholder.com/80?text=Michael",
      "trainerBio": "Professional swimmer and coach."
    },
    {
      "className": "Cardio Blast",
      "time": "Sat - 8:00 AM to 9:00 AM",
      "trainerName": "Emily",
      "imageUrl": "https://via.placeholder.com/80?text=Cardio+Blast",
      "trainerImage": "https://via.placeholder.com/80?text=Emily",
      "trainerBio": "Cardio fitness specialist."
    },
  ];

  // Controller for the search field
  final TextEditingController _searchController = TextEditingController();

  // List to hold filtered class details
  List<Map<String, String>> filteredClassDetails = [];

  @override
  void initState() {
    super.initState();
    filteredClassDetails = classDetails;
    _searchController.addListener(_filterClasses);
  }

  // Filter function based on search query
  void _filterClasses() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredClassDetails = classDetails.where((classInfo) {
        final className = classInfo['className']!.toLowerCase();
        final trainerName = classInfo['trainerName']!.toLowerCase();
        return className.contains(query) || trainerName.contains(query);
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
    // Initialize ScreenUtil for responsiveness
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: EdgeInsets.all(8.w), // Use ScreenUtil to set responsive padding
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by class name or trainer name...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r), // Responsive border radius
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // List of filtered classes
          Expanded(
            child: filteredClassDetails.isEmpty
                ? Center(
              child: Text(
                "No classes found",
                style: TextStyle(fontSize: 16.sp), // Responsive font size
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.all(10.w), // Use ScreenUtil to set responsive padding
              itemCount: filteredClassDetails.length,
              itemBuilder: (context, index) {
                final classInfo = filteredClassDetails[index];
                return Card(
                  color: const Color(0xFFF0F8F5),
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 5.h), // Responsive margin
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r), // Responsive border radius
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.w), // Responsive padding
                    leading: CircleAvatar(
                      radius: 40.w, // Responsive avatar size
                      backgroundImage: NetworkImage(
                        classInfo['imageUrl']!,
                      ),
                      backgroundColor: Colors.grey[200],
                    ),
                    title: Text(
                      classInfo['className']!,
                      style: TextStyle(
                        fontSize: 18.sp, // Responsive font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h), // Responsive spacing
                        Text(
                          "Time: ${classInfo['time']!}",
                          style: TextStyle(fontSize: 14.sp), // Responsive font size
                        ),
                        SizedBox(height: 5.h), // Responsive spacing
                        Text(
                          "Trainer: ${classInfo['trainerName']!}",
                          style: TextStyle(
                            fontSize: 14.sp, // Responsive font size
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {
                      // Navigate to the Class Detail Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClassDetailPage(classInfo: classInfo),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
