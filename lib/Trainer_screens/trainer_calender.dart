import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;

  // Data structure to store classes by date
  Map<DateTime, List<String>> _classes = {};

  // Helper to format dates without the time part for comparison
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF659F62),
        toolbarHeight: 80,
        title: Text(
          "CALENDAR",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Header
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Manage Calendar",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 10),
          // Date Picker Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _focusedDay = pickedDate;
                        _selectedDay = pickedDate;
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
              _showScheduleClassDialog(selectedDay);
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
          SizedBox(height: 10),
          // Display List of Scheduled Classes
          Expanded(
            child: _selectedDay == null
                ? Center(child: Text('Select a date to view scheduled classes'))
                : _buildClassList(),
          ),
        ],
      ),
    );
  }

  // Widget to display the list of classes
  Widget _buildClassList() {
    final normalizedDate = _normalizeDate(_selectedDay!);
    final classesForDate = _classes[normalizedDate] ?? [];

    return classesForDate.isEmpty
        ? Center(child: Text('No classes scheduled for this date'))
        : ListView.builder(
      itemCount: classesForDate.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          color: Color(0xFFCDEAC0),
          child: ListTile(
            title: Text(
              classesForDate[index],
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF659F62)),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  classesForDate.removeAt(index);
                  if (classesForDate.isEmpty) {
                    _classes.remove(normalizedDate);
                  }
                });
              },
            ),
          ),
        );
      },
    );
  }

  // Helper to show a dialog to schedule a class
  void _showScheduleClassDialog(DateTime date) {
    final TextEditingController classController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Schedule Class"),
          content: TextField(
            controller: classController,
            decoration: InputDecoration(
              labelText: "Class Details",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel",style: TextStyle(fontWeight: FontWeight.w500),),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (classController.text.isNotEmpty) {
                  setState(() {
                    final normalizedDate = _normalizeDate(date);
                    _classes.putIfAbsent(normalizedDate, () => []).add(classController.text);
                  });
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF659F62)),
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Helper to get the name of the month
  String _monthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}
