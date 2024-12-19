import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LearnerDashboard extends StatefulWidget {
  @override
  _LearnerDashboardState createState() => _LearnerDashboardState();
}

class _LearnerDashboardState extends State<LearnerDashboard>
    with SingleTickerProviderStateMixin {
  final Map<String, dynamic> learnerData = {
    "name": "John Doe",
    "profilePic": "assets/profile_pic.png",
    "currentLearning": "Swimming",
    "classTime": "10:00 AM - 11:00 AM",
    "performance": {
      "Stamina": "Improved by 15%",
      "Technique": "Improved by 10%",
      "Speed": "Consistent improvement"
    },
    "weeklyHours": [2, 1, 3, 2, 4, 3, 5], // Hours worked for each day of the week
  };

  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80,

        title: const Text(
          "LEARNER DASHBOARD",
          style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),
        ),
        backgroundColor: Color(0xFF659F62),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _fadeInAnimation,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Section
                Card(
                  color: Color(0xFFF0F8F5),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(learnerData["profilePic"]),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              learnerData["name"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Current Learning: ${learnerData["currentLearning"]}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Class Time: ${learnerData["classTime"]}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Performance Section
                const Text(
                  "Performance",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Card(
                  color: Color(0xFFF0F8F5),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: learnerData["performance"].entries.map<Widget>((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.trending_up,
                                  color: Colors.blue, size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "${entry.key}: ${entry.value}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Chart Section
                const Text(
                  "Weekly Activity (Hours)",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Card(
                  color: Color(0xFFF0F8F5),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 5,
                          barTouchData: BarTouchData(enabled: true),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(fontSize: 12),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const days = [
                                    'Mon',
                                    'Tue',
                                    'Wed',
                                    'Thu',
                                    'Fri',
                                    'Sat',
                                    'Sun'
                                  ];
                                  return Text(
                                    days[value.toInt()],
                                    style: const TextStyle(fontSize: 12),
                                  );
                                },
                              ),
                            ),
                          ),
                          barGroups: List.generate(
                            learnerData["weeklyHours"].length,
                                (index) => BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: learnerData["weeklyHours"][index]
                                      .toDouble(),
                                  color: Color(0xFF659F62),
                                  width: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
