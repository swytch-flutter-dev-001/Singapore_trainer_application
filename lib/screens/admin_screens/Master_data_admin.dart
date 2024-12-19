import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminMDMPage extends StatefulWidget {
  const AdminMDMPage({Key? key}) : super(key: key);

  @override
  _AdminMDMPageState createState() => _AdminMDMPageState();
}

class _AdminMDMPageState extends State<AdminMDMPage> {
  final List<Map<String, String>> trainers = [
    {'name': 'John Doe', 'role': 'Trainer', 'activity': '8'},
    {'name': 'Jane Smith', 'role': 'Trainer', 'activity': '5'},
  ];

  final List<Map<String, String>> learners = [
    {'name': 'Michael Johnson', 'role': 'Learner'},
    {'name': 'Sarah Lee', 'role': 'Learner'},
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'ADMIN - MDM',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        backgroundColor: Color(0xFF659F62),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                // Implement logout functionality
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Trainers Overview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildTrainerChart(),
              const SizedBox(height: 24),
              const Text(
                'Manage Trainers',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildSearchBar(),
              _buildUserListView(
                trainers.where((trainer) => trainer['name']!.toLowerCase().contains(searchQuery.toLowerCase())).toList(),
                'Trainer',
              ),
              const SizedBox(height: 24),
              const Text(
                'Manage Learners',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              _buildUserListView(
                learners.where((learner) => learner['name']!.toLowerCase().contains(searchQuery.toLowerCase())).toList(),
                'Learner',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Trainer activity chart widget
  Widget _buildTrainerChart() {
    return Card(
      color: Color(0xFFF0F8F5),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Trainer Activity (Hours)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: trainers.map((trainer) {
                    final activity = int.tryParse(trainer['activity'] ?? '0') ?? 0;
                    return BarChartGroupData(
                      x: trainers.indexOf(trainer),
                      barRods: [
                        BarChartRodData(
                          toY: activity.toDouble(),
                          gradient: LinearGradient(
                            colors: [Color(0xFF659F62), Color(0xFF92C287)],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }).toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < trainers.length) {
                            return Text(
                              trainers[index]['name'] ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      axisNameWidget: const Text('Trainers'),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 2,
                      ),
                      axisNameWidget: const Text('Activity Hours'),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Search bar widget
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Search by Name',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onChanged: (query) {
        setState(() {
          searchQuery = query;
        });
      },
    );
  }

  // Function to build user list in cards
  Widget _buildUserListView(List<Map<String, String>> users, String role) {
    return ListView.builder(
      shrinkWrap: true, // Prevent overflow by limiting height
      physics: NeverScrollableScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          color: Color(0xFFCDEAC0),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text(user['name']!, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF659F62))),
            subtitle: Text(user['role']!, style: TextStyle(color: Colors.black)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Color(0xFF659F62)),
                  onPressed: () {
                    _editUser(user, role);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _deleteUser(user, role);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to edit a user
  void _editUser(Map<String, String> user, String role) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserPage(user: user, role: role),
      ),
    );
  }

  // Function to delete a user with confirmation dialog
  void _deleteUser(Map<String, String> user, String role) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete ${user['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() {
                if (role == 'Trainer') {
                  trainers.remove(user);
                } else {
                  learners.remove(user);
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class EditUserPage extends StatelessWidget {
  final Map<String, String> user;
  final String role;

  const EditUserPage({required this.user, required this.role});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: user['name']);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: const Text('Edit User',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
        backgroundColor: Color(0xFF659F62),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF659F62),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                user['name'] = nameController.text;
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
