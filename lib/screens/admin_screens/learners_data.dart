// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// class LearnerInsightCharts extends StatelessWidget {
//   final Map<String, String> learnerData;
//
//   const LearnerInsightCharts({super.key, required this.learnerData});
//
//   @override
//   Widget build(BuildContext context) {
//     // Safe parsing of string to double
//     double performance = double.tryParse(learnerData['performance'] ?? '0') ?? 0;
//     double progress = double.tryParse(learnerData['progress'] ?? '0') ?? 0;
//     int completedTasks = int.tryParse(learnerData['completedTasks'] ?? '0') ?? 0;
//     int totalTasks = int.tryParse(learnerData['totalTasks'] ?? '0') ?? 0;
//
//     // Validate the parsed values to ensure they are not NaN or Infinity
//     if (performance.isNaN || performance.isInfinite) {
//       performance = 0;  // Set a default valid value
//     }
//
//     if (progress.isNaN || progress.isInfinite) {
//       progress = 0;  // Set a default valid value
//     }
//
//     // Line chart data for Performance over time
//     List<FlSpot> performanceData = [
//       FlSpot(0, performance), // Initial performance
//       FlSpot(1, performance + 5), // Day 1
//       FlSpot(2, performance + 10), // Day 2
//       FlSpot(3, performance + 12), // Day 3
//     ];
//
//     // Bar chart data for Completed tasks vs Total tasks
//     List<BarChartGroupData> taskCompletionData = [
//       BarChartGroupData(
//         x: 0,
//         barRods: [
//           BarChartRodData(
//             toY: completedTasks.toDouble(),
//             color: Colors.blue,
//             width: 15,
//           ),
//         ],
//       ),
//       BarChartGroupData(
//         x: 1,
//         barRods: [
//           BarChartRodData(
//             toY: (totalTasks - completedTasks).toDouble(),
//             color: Colors.red,
//             width: 15,
//           ),
//         ],
//       ),
//     ];
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Learner Insights")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Learner's Data
//             Text('Name: ${learnerData['name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text('Performance: ${performance.toStringAsFixed(2)}%', style: TextStyle(fontSize: 18)),
//             Text('Progress: ${progress.toStringAsFixed(2)} / ${learnerData['totalClasses']} Classes', style: TextStyle(fontSize: 18)),
//
//             SizedBox(height: 20),
//
//             // Line Chart for Performance Insights
//             Text('Performance Over Time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             LineChart(
//               LineChartData(
//                 gridData: FlGridData(show: true),
//                 titlesData: FlTitlesData(show: true),
//                 borderData: FlBorderData(show: true),
//                 lineBarsData: [
//                   LineChartBarData(
//                     spots: performanceData,
//                     isCurved: true,
//                     color: Colors.green,
//                     belowBarData: BarAreaData(show: true, color: Colors.green.withOpacity(0.3)),
//                   ),
//                 ],
//               ),
//             ),
//
//             SizedBox(height: 20),
//
//             // Bar Chart for Task Completion Insights
//             Text('Task Completion (Completed vs Total)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             BarChart(
//               BarChartData(
//                 gridData: FlGridData(show: true),
//                 titlesData: FlTitlesData(show: true),
//                 borderData: FlBorderData(show: true),
//                 barGroups: taskCompletionData,
//               ),
//             ),
//
//             SizedBox(height: 20),
//
//             // Report Section
//             Text('Report', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             Text('Total Classes: ${learnerData['totalClasses']}'),
//             Text('Completed Tasks: $completedTasks'),
//             Text('Remaining Tasks: ${totalTasks - completedTasks}'),
//             Text('Performance Improvement: ${performance.toStringAsFixed(2)}%'),
//             Text('Progress: ${progress.toStringAsFixed(2)} / $totalTasks Classes'),
//           ],
//         ),
//       ),
//     );
//   }
// }
