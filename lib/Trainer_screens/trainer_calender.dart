import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    // Initialize ScreenUtil for responsiveness
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF659F62),
        toolbarHeight: 80.h,
        title: Text(
          "CALENDAR",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),

            // Header
            Text(
              "Manage Your Calendar",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.black),
            ),
            SizedBox(height: 10.h),

            // Date Picker Button
            _buildDatePickerButton(),

            SizedBox(height: 10.h),

            // Calendar Widget
            _buildCalendar(),

            SizedBox(height: 10.h),

            // Display List of Scheduled Classes
            Expanded(
              child: _selectedDay == null
                  ? Center(
                child: Text(
                  'Select a date to view scheduled classes',
                  style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                ),
              )
                  : _buildClassList(),
            ),
          ],
        ),
      ),
    );
  }

  // Date Picker Button
  Widget _buildDatePickerButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
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
                      primary: Color(0xFF659F62), // Header color
                      onPrimary: Colors.white,    // Header text color
                      onSurface: Colors.black,    // Body text color
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xFF659F62), // Button text color
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
                _selectedDay = pickedDate;
              });
            }
          },
          icon: Icon(Icons.calendar_today, size: 20.sp,color: Colors.white,),
          label: Text(
            "${_monthName(_focusedDay.month)} ${_focusedDay.year}",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFF659F62),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        ),
      ],
    );
  }

  // Calendar Widget
  Widget _buildCalendar() {
    return TableCalendar(
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
          color: Color(0xFF659F62),
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.circle,
        ),
        markerDecoration: BoxDecoration(
          color: Color(0xFF92C287),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  // List of Scheduled Classes
  Widget _buildClassList() {
    final normalizedDate = _normalizeDate(_selectedDay!);
    final classesForDate = _classes[normalizedDate] ?? [];

    return classesForDate.isEmpty
        ? Center(
      child: Text(
        'No classes scheduled for this date',
        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
      ),
    )
        : ListView.builder(
      itemCount: classesForDate.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          color: Color(0xFFCDEAC0),
          child: ListTile(
            title: Text(
              classesForDate[index],
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Color(0xFF659F62)),
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

  // Schedule Class Dialog
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
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(fontWeight: FontWeight.w500)),
            ),
            ElevatedButton(
              onPressed: () {
                if (classController.text.isNotEmpty) {
                  setState(() {
                    final normalizedDate = _normalizeDate(date);
                    _classes.putIfAbsent(normalizedDate, () => []).add(classController.text);
                  });
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF659F62),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Helper to get month name
  String _monthName(int month) {
    return [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ][month];
  }
}
