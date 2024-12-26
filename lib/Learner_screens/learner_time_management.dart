import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeManagementPage extends StatefulWidget {
  @override
  _TimeManagementPageState createState() => _TimeManagementPageState();
}

class _TimeManagementPageState extends State<TimeManagementPage> {
  List<Map<String, dynamic>> tasks = [
    {'title': 'Submit Project Report', 'deadline': '4:00 PM', 'isCompleted': true},
    {'title': 'Prepare Presentation', 'deadline': '6:00 PM', 'isCompleted': false},
  ];

  List<Map<String, dynamic>> completedTasks = [];

  List<Map<String, dynamic>> upcomingClasses = [
    {'title': 'Yoga Class', 'date': 'Mon, 10:00 AM'},
    {'title': 'Pilates Class', 'date': 'Tue, 2:00 PM'},
  ];

  void _markTaskAsComplete(int index) {
    setState(() {
      completedTasks.add(tasks[index]);
      tasks.removeAt(index);
    });
  }

  void _addNewTask() {
    setState(() {
      tasks.add({'title': 'New Task', 'deadline': '2:00 PM', 'isCompleted': true});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF659F62),
          onPressed: _addNewTask),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        toolbarHeight: 70.h,
        title: Text(
          'TIME MANAGEMENT',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: Color(0xFF659F62),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.add),
        //     onPressed: _addNewTask,
        //   ),
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tasks Section
              Text(
                'My Tasks',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              ...tasks.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> task = entry.value;
                return Card(
                  elevation: 3,
                  child: ListTile(
                    title: Text(task['title']),
                    subtitle: Text('Deadline: ${task['deadline']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.check_circle, color: Colors.green),
                      onPressed: () => _markTaskAsComplete(index),
                    ),
                  ),
                );
              }).toList(),
              Divider(height: 30.h, thickness: 2),

              // Completed Tasks Section
              Text(
                'Completed Tasks',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              completedTasks.isEmpty
                  ? Text('No completed tasks yet.')
                  : Column(
                children: completedTasks.map((task) {
                  return Card(
                    color: Colors.green[100],
                    child: ListTile(
                      title: Text(task['title']),
                      subtitle: Text('Completed at: ${task['deadline']}'),
                    ),
                  );
                }).toList(),
              ),
              Divider(height: 30.h, thickness: 2),

              // Upcoming Classes Section
              Text(
                'Upcoming Classes',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              ...upcomingClasses.map((cls) {
                return Card(
                  elevation: 3,
                  child: ListTile(
                    title: Text(cls['title']),
                    subtitle: Text('Scheduled on: ${cls['date']}'),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
