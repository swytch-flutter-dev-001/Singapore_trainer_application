import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LernerCalendarPage extends StatefulWidget {
  @override
  _LernerCalendarPageState createState() => _LernerCalendarPageState();
}

class _LernerCalendarPageState extends State<LernerCalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final CalendarFormat _calendarFormat = CalendarFormat.week;

  // List of class events
  final List<Map<String, dynamic>> _events = [
    {
      "title": "Beginner Swimming",
      "time": "10:00 AM - 11:00 AM",
      "date": DateTime(2024, 12, 7),
    },
    {
      "title": "Advanced Yoga",
      "time": "11:30 AM - 12:30 PM",
      "date": DateTime(2024, 12, 7),
    },
    {
      "title": "Hip Hop Dance",
      "time": "2:00 PM - 3:00 PM",
      "date": DateTime(2024, 12, 8),
    },
    {
      "title": "Karate Basics",
      "time": "4:00 PM - 5:00 PM",
      "date": DateTime(2024, 12, 9),
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter events based on the selected day
    final selectedEvents = _events
        .where((event) => isSameDay(event["date"], _selectedDay))
        .toList();

    return Scaffold(
      backgroundColor: Color(0xFFF0F8F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF659F62), // Dark Green for branding
        title: Text(
          "CALENDER",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.sp, color: Colors.white),
        ),
        toolbarHeight: 80,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          // Header with a modern, clean style
          Padding(
            padding: const EdgeInsets.only(right: 190),
            child: Text(
              "Manage Your Classes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
            ),
          ),
          SizedBox(height: 10.h),
          // Month Selector Row with a professional, interactive look
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Button to pick date with a modern design
                Container(
                  decoration: BoxDecoration(

                    color: const Color(0xFF659F62),
                    borderRadius: BorderRadius.circular(10),

                  ),

                  child: TextButton.icon(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: _focusedDay,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFF659F62), // Header color
                                onPrimary: Colors.white, // Header text color
                                onSurface: Colors.black, // Body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xFF659F62), // Button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _focusedDay = pickedDate;
                          _selectedDay = pickedDate; // Set selected day to the picked date
                        });
                      }
                    },
                    icon: const Icon(Icons.calendar_today, color: Colors.white),
                    label: Text(
                      "${_monthName(_focusedDay.month)} ${_focusedDay.year}",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Calendar Widget with enhanced look and feel
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              headerVisible: false,
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                  color: Color(0xFF659F62), // Selected day color
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          // Display Events for the Selected Day
          if (selectedEvents.isEmpty)
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Text("No classes on this day", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400)),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: selectedEvents.length,
                itemBuilder: (context, index) {
                  final event = selectedEvents[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      title: Text(event["title"], style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                      subtitle: Text("Time: ${event['time']}", style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300)),
                      leading: const Icon(Icons.event, color: Color(0xFF659F62)),
                      onTap: () {
                        // Optional: Add onTap functionality to show event details
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

  // Helper to get the name of the month
  String _monthName(int month) {
    switch (month) {
      case 1: return 'January';
      case 2: return 'February';
      case 3: return 'March';
      case 4: return 'April';
      case 5: return 'May';
      case 6: return 'June';
      case 7: return 'July';
      case 8: return 'August';
      case 9: return 'September';
      case 10: return 'October';
      case 11: return 'November';
      case 12: return 'December';
      default: return '';
    }
  }
}
