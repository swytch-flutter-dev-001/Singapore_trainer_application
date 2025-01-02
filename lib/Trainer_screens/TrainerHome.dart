import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:singapore_trainer_app/Trainer_screens/Details_page.dart';
import 'package:singapore_trainer_app/Trainer_screens/trainer_calender.dart';
import 'package:singapore_trainer_app/Trainer_screens/trainer_chat.dart';
import 'package:singapore_trainer_app/Trainer_screens/trainer_reviews.dart';
import 'package:singapore_trainer_app/Trainer_screens/Trainer_dashboard.dart';
import 'package:singapore_trainer_app/Trainer_screens/Trainer_profile.dart';
import '../Views/login_view.dart';
import 'Notification_trainer.dart';
import 'Trainer_screening.dart';
import 'batch_management.dart';
import 'trainer_plans_subcriptions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrainerHome extends StatefulWidget {
  const TrainerHome({super.key});

  @override
  State<TrainerHome> createState() => _TrainerHomeState();
}

class _TrainerHomeState extends State<TrainerHome> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> tabs = [
    DETAILS(),
    ChatingTrainer(),
    CalendarPage(),
    TrainerReviews(),
  ];

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsiveness
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F8F5),
      appBar: selectedIndex == 0
          ? AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF659F62),
        toolbarHeight: 70.h, // Responsive height
        title: Text(
          "TRAINER HOME",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.sp, // Responsive font size
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10.w), // Responsive padding
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const notification_Trainer(),
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ),
        ],
      )
          : null, // Hide AppBar for other pages
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            SizedBox(height: 20.h), // Responsive height
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF659F62)),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TrainerProfile(),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 40, // Responsive radius
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                  ),
                  SizedBox(height: 10.h), // Responsive height
                  const Text(
                    "TRAINER MENU",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrainerDashboard(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.subscriptions_outlined),
              title: const Text("Plans"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubscriptionPlansPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.batch_prediction),
              title: const Text("Batch Management"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BatchManagementPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: FaIcon(Icons.more_time_rounded),
              title: const Text("Screening Time"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreeningTimePage(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 290.h, // Responsive height
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your login page widget
                );
                // Logout action can be added here
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: tabs,
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: selectedIndex,
        backgroundColor: Colors.white,
        iconSize: 30.sp, // Responsive icon size
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home),
            title: Text('Home', style: TextStyle(fontSize: 12.sp)), // Responsive font size
            activeColor: const Color(0xFF659F62),
            inactiveColor: Colors.black,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.chat),
            title: Text('Chat', style: TextStyle(fontSize: 12.sp)), // Responsive font size
            activeColor: const Color(0xFF659F62),
            inactiveColor: Colors.black,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.calendar_month),
            title: Text('Calendar', style: TextStyle(fontSize: 12.sp)), // Responsive font size
            activeColor: const Color(0xFF659F62),
            inactiveColor: Colors.black,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.reviews),
            title: Text('Reviews', style: TextStyle(fontSize: 12.sp)), // Responsive font size
            activeColor: const Color(0xFF659F62),
            inactiveColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
