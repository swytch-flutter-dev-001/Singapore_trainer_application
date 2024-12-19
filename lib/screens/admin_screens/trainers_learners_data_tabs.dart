import 'package:flutter/material.dart';

import 'admin_trainer_details.dart';
import 'learners_data.dart';

class trainers_learners_data extends StatefulWidget {
  const trainers_learners_data({super.key});

  @override
  State<trainers_learners_data> createState() => _trainers_learners_dataState();
}

class _trainers_learners_dataState extends State<trainers_learners_data>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          // TabBar without AppBar
          Container(
            width: 330,
            // Dark Green background for the TabBar
            child: Card(
              color: Color(0xFF659F62),
              child: TabBar(

                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicatorColor: Color(0xFFCDEAC0), // Light Green
                tabs: [
                  Tab(child: Text("Trainers",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),) ),
                  Tab(child: Text("Learners",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),) ),
                ],
              ),
            ),
          ),
          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Manage Trainers Tab
                ManageTrainersTab(),

                // Manage Learners Tab
                ManageLearnersTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ManageTrainersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 5, // Replace with dynamic data for trainers
      itemBuilder: (context, index) {
        return Card(
          color: Color(0xFFF0F8F5), // Light Green
          margin: EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {


            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFF92C287), // Medium Green
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                "Trainer ${index + 1}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Work: Guiding learners on topic XYZ"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
        );
      },
    );
  }
}

class ManageLearnersTab extends StatelessWidget {
  // Sample data for learners
  final List<Map<String, String>> learners = [
    {'name': 'Learner 1', 'performance': '85', 'progress': '8', 'totalClasses': '10'},
    {'name': 'Learner 2', 'performance': '90', 'progress': '9', 'totalClasses': '10'},
    {'name': 'Learner 3', 'performance': '78', 'progress': '7', 'totalClasses': '10'},
    // Add more learner data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: learners.length, // Use dynamic data
      itemBuilder: (context, index) {
        return Card(
          color: Color(0xFFF0F8F5), // Light Green
          margin: EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              // Passing learner data to the LearnerInsightCharts page
              // WidgetsBinding.instance.addPostFrameCallback((_) {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => LearnerInsightCharts(
                //       learnerData: learners[index], // Pass the specific learner's data
                //     ),
                //   ),
                // );
              // });
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFF92C287), // Medium Green
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                learners[index]['name']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Requested to join Class ABC"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ),
        );
      },
    );
  }
}
