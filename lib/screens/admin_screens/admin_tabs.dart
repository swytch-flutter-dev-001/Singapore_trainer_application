import 'package:flutter/material.dart';
import 'package:singapore_trainer_app/screens/admin_screens/trainers_learners_data_tabs.dart';

import 'admin_trainer_accept_reject.dart';
import 'Learner_accept_reject_page.dart';

class AdminTabs extends StatefulWidget {
  const AdminTabs({super.key});

  @override
  State<AdminTabs> createState() => _AdminTabsState();
}

class _AdminTabsState extends State<AdminTabs>
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
          const SizedBox(height: 20),

          // TabBar without AppBar
          Container(
            width: 330,
            child: Card(
              color: const Color(0xFF659F62), // Dark Green background
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicatorColor: const Color(0xFFCDEAC0), // Light Green
                tabs: const [
                  Tab(
                    child: Text(
                      "Trainers",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Learners",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // TabBarView for managing Trainers and Learners
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
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

class ManageLearnersTab extends StatelessWidget {
  const ManageLearnersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5, // Replace with dynamic data for learners
      itemBuilder: (context, index) {
        return Card(
          color: const Color(0xFFF0F8F5),
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AcceptReject(),
                ),
              );
            },
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/Singapore Trainers-2.png"),
               radius: 30,
              ),
              title: Text(
                "Arnold ${index + 1}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("Requested to join Class Swimming"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Request Accepted"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Request Rejected"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
class ManageTrainersTab extends StatelessWidget {
  const ManageTrainersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5, // Replace with dynamic data for trainers
      itemBuilder: (context, index) {
        return Card(
          color: const Color(0xFFF0F8F5),
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TrainerAcceptReject(),
                ),
              );
            },
            child: ListTile(
              leading: const CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage("assets/images/Singapore Trainers-2.png"),
              ),
              title: Text(
                "Trainer ${index + 1}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("Requested to join as a Trainer"),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Trainer Request Accepted"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Trainer Request Rejected"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
