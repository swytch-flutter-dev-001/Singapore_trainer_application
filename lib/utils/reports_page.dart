import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Make sure this package is added to your pubspec.yaml

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String selectedCategory = "All";

  // Data for trainers and learners (could be dynamic or fetched from API)
  final List<Map<String, dynamic>> trainerData = [
    {"name": "John Smith", "category": "Swimming", "detail": "3 Classes Conducted"},
    {"name": "Jane Doe", "category": "Yoga", "detail": "5 Classes Conducted"},
  ];

  final List<Map<String, dynamic>> learnerData = [
    {"name": "Michael Brown", "category": "Swimming", "detail": "Completed 10 Sessions"},
    {"name": "Emily Davis", "category": "Yoga", "detail": "Completed 15 Sessions"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: const Text("REPORTS",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.white),),
        backgroundColor: const Color(0xFF659F62), // Dark Green
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildFilterSection(),
            const SizedBox(height: 20),
            _buildSectionHeader("Trainer Reports"),
            _buildChartSection("Trainer Performance", trainerData.length),
            ...trainerData.map((trainer) => _buildReportItem(
                trainer['name'], trainer['category'], trainer['detail'])).toList(),
            const SizedBox(height: 20),
            _buildSectionHeader("Learner Reports"),
            _buildChartSection("Learner Performance", learnerData.length),
            ...learnerData.map((learner) => _buildReportItem(
                learner['name'], learner['category'], learner['detail'])).toList(),
          ],
        ),
      ),
    );
  }

  // Filter section for selecting category (All, Swimming, Yoga)
  Widget _buildFilterSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Filter by Category:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        DropdownButton<String>(
          value: selectedCategory,
          items: ["All", "Swimming", "Yoga"].map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (String? newCategory) {
            setState(() {
              selectedCategory = newCategory!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildReportItem(String name, String category, String detail) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey.shade100,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF92C287), // Medium Green
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text("$category - $detail"),
      ),
    );
  }

  // Chart section for displaying performance (trainer or learner)
  Widget _buildChartSection(String title, int count) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          height: 200,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: PieChart(
            PieChartData(
              sectionsSpace: 0, // No space between sections
              centerSpaceRadius: 30, // Center space radius
              sections: [
                PieChartSectionData(
                  color: const Color(0xFF659F62), // Dark Green
                  value: count.toDouble(),
                  title: '$count',
                  radius: 50,
                  titleStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                PieChartSectionData(
                  color: Colors.grey.shade400, // Light grey for the remaining space
                  value: 100 - count.toDouble(),
                  title: '',
                  radius: 50,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
