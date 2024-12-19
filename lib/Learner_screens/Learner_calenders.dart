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
  CalendarFormat _calendarFormat = CalendarFormat.week;

  // List of class events, each event has a title, date, and time
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
      backgroundColor: Colors.white,
      appBar: AppBar(

        backgroundColor: Color(0xFF659F62),
        title: Text("CALENDER",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.white),),
        toolbarHeight: 80,
        iconTheme: IconThemeData(
          color: Colors.white,
          
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          // Header
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Text(
              "Manage Calendar",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 10.h),
          // Month Selector Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Button to pick date
                TextButton.icon(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _focusedDay,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Colors.green, // Header color
                              onPrimary: Colors.white, // Header text color
                              onSurface: Colors.black, // Body text color
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.green, // Button text color
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
                  icon: Icon(Icons.calendar_today, color: Colors.green),
                  label: Text(
                    "${_monthName(_focusedDay.month)} ${_focusedDay.year}",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          // Calendar Widget
          TableCalendar(
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
              selectedDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(height: 20),
          // Display Events for the Selected Day in a ListView
          if (selectedEvents.isEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("No classes on this day", style: TextStyle(fontSize: 16)),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: selectedEvents.length,
                itemBuilder: (context, index) {
                  final event = selectedEvents[index];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    title: Text(event["title"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    subtitle: Text("Time: ${event['time']}", style: TextStyle(fontSize: 14)),
                    leading: Icon(Icons.event, color: Colors.green),
                    onTap: () {
                      // Optional: Add onTap functionality to show event details
                    },
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
