import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TrainerDashboard extends StatefulWidget {
  @override
  _TrainerDashboardState createState() => _TrainerDashboardState();
}

class _TrainerDashboardState extends State<TrainerDashboard> {
  // Learner data including their time spent on each training
  final List<Map<String, dynamic>> learnersData = [
    {'name': 'Michael', 'training': 'Swimming', 'timeSpent': '5 hrs', 'status': 'Active'},
    {'name': 'Sarah', 'training': 'Hockey', 'timeSpent': '8 hrs', 'status': 'Completed'},
    {'name': 'John', 'training': 'Cricket', 'timeSpent': '10 hrs', 'status': 'Active'},
    {'name': 'Anna', 'training': 'Badminton', 'timeSpent': '3 hrs', 'status': 'Active'},
  ];

  final List<Map<String, dynamic>> sportsData = [
    {'name': 'Swimming', 'totalTime': 18, 'learners': 3},
    {'name': 'Hockey', 'totalTime': 16, 'learners': 2},
    {'name': 'Cricket', 'totalTime': 20, 'learners': 4},
    {'name': 'Badminton', 'totalTime': 12, 'learners': 2},
  ];

  final List<Color> chartColors = [
    const Color(0xFF659F62),
    const Color(0xFF92C287),
    const Color(0xFFCDEAC0),
    Colors.blue,
  ];

  String _selectedStatus = 'All';

  /// Filter learners by status
  List<Map<String, dynamic>> get filteredLearners {
    if (_selectedStatus == 'All') return learnersData;
    return learnersData.where((learner) => learner['status'] == _selectedStatus).toList();
  }

  /// Show filter dialog
  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.filter_list),
            title: const Text('Show All'),
            onTap: () {
              setState(() => _selectedStatus = 'All');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.check_circle, color: Colors.green),
            title: const Text('Active Learners'),
            onTap: () {
              setState(() => _selectedStatus = 'Active');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.done_all, color: Colors.blue),
            title: const Text('Completed Learners'),
            onTap: () {
              setState(() => _selectedStatus = 'Completed');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
              onPressed: _showFilterDialog,
              icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
            ),
          ),
        ],
        title: const Text(
          'TRAINER DASHBOARD',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF659F62),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOverviewSection(),
              const SizedBox(height: 24),
              const Text('Learner Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              const SizedBox(height: 16),
              _buildLearnerTable(),
              const SizedBox(height: 24),
              const Text('Training Sessions Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              const SizedBox(height: 16),
              _buildTrainingSessionsSummary(),
              const SizedBox(height: 24),
              _buildChartsSection(),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildShortcuts(),
    );
  }

  Widget _buildOverviewSection() {
    return Card(
      color: const Color(0xFFF0F8F5),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildOverviewCard('Learners', '${learnersData.length}'),
            _buildOverviewCard('Trainings', '${sportsData.length}'),
            _buildOverviewCard('Avg Time', '6 hrs'),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
      ],
    );
  }

  Widget _buildLearnerTable() {
    return Column(
      children: filteredLearners.map((learner) {
        return Card(
          color: const Color(0xFFF0F8F5),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text('Name: ${learner['name']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Training: ${learner['training']}'),
                Text('Time Spent: ${learner['timeSpent']}'),
                Text('Status: ${learner['status']}', style: TextStyle(color: _getStatusColor(learner['status']))),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTrainingSessionsSummary() {
    return Card(
      color: const Color(0xFFF0F8F5),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: sportsData.map((training) {
          return ListTile(
            title: Text(training['name']),
            subtitle: Text('${training['learners']} learners • Total Time: ${training['totalTime']} hrs'),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChartsSection() {
    return Row(
      children: [
        Expanded(child: _buildPieChart()),
        const SizedBox(width: 16),
        Expanded(child: _buildBarChart()),
      ],
    );
  }

  Widget _buildPieChart() {
    return Card(
      child: const Text("Pie Chart Placeholder"), // Simplified for brevity
    );
  }

  Widget _buildBarChart() {
    return Card(
      child: const Text("Bar Chart Placeholder"), // Simplified for brevity
    );
  }

  /// Quick-Access Shortcuts
  Widget _buildShortcuts() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'chart',
          onPressed: () => _scrollToSection('charts'),
          child: const Icon(Icons.pie_chart),
          backgroundColor: const Color(0xFF659F62),
        ),
        const SizedBox(height: 16),
        FloatingActionButton(
          heroTag: 'learners',
          onPressed: () => _scrollToSection('learners'),
          child: const Icon(Icons.people),
          backgroundColor: const Color(0xFF92C287),
        ),
      ],
    );
  }

  void _scrollToSection(String section) {
    // Implement scrolling logic
  }

  Color _getStatusColor(String status) {
    return status == 'Active' ? Colors.green : Colors.blue;
  }
}
