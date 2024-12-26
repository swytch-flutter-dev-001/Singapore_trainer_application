import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/screening.dart';

class ScreeningTimePage extends StatefulWidget {
  @override
  _ScreeningTimePageState createState() => _ScreeningTimePageState();
}

class _ScreeningTimePageState extends State<ScreeningTimePage> {
  final List<Screening> screenings = [
    Screening(
        service: 'Swimming Class',
        date: DateTime.now().add(Duration(days: 2)),
        time: '2:00 PM',
        location: 'Training Pool A',
        isCompleted: false),
    Screening(
        service: 'Yoga Class',
        date: DateTime.now().subtract(Duration(days: 1)),
        time: '4:00 PM',
        location: 'Studio B',
        isCompleted: true),
  ];

  String filter = 'Upcoming';

  @override
  Widget build(BuildContext context) {
    List<Screening> filteredScreenings = screenings.where((screening) {
      if (filter == 'Upcoming') {
        return !screening.isCompleted && screening.date.isAfter(DateTime.now());
      } else if (filter == 'Completed') {
        return screening.isCompleted;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.h,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'MY SCREENING TIME',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: Color(0xFF659F62), // Dark Green
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter buttons with more appealing design
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAnimatedFilterButton('Upcoming'),
                SizedBox(width: 10),
                _buildAnimatedFilterButton('Completed'),
                SizedBox(width: 10),
                _buildAnimatedFilterButton('All'),
              ],
            ),
            SizedBox(height: 16),
            // Screenings List with smooth transitions
            Expanded(
              child: ListView.builder(
                itemCount: filteredScreenings.length,
                itemBuilder: (context, index) {
                  final screening = filteredScreenings[index];
                  return _buildAnimatedScreeningCard(screening);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedFilterButton(String title) {
    bool isActive = filter == title;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
        boxShadow: isActive
            ? [BoxShadow(color: Colors.green.withOpacity(0.5), blurRadius: 10, offset: Offset(0, 4))]
            : null,
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            filter = title;
          });
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), backgroundColor: Colors.transparent, // Transparent background to show the AnimatedContainer color
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedScreeningCard(Screening screening) {
    return AnimatedScale(
      duration: Duration(milliseconds: 300),
      scale: 1.05,
      child: GestureDetector(
        onTap: () {
          // Implement any action for tap
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.symmetric(vertical: 8),
          child: InkWell(
            onTap: () {
              // Action on tap (show more details, etc.)
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    screening.isCompleted ? Icons.check_circle : Icons.schedule,
                    color: screening.isCompleted ? Colors.green : Colors.blue,
                    size: 40,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          screening.service,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${screening.date.toLocal().toString().split(' ')[0]} at ${screening.time}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Location: ${screening.location}',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
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
}
