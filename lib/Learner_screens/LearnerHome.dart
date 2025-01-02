import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:singapore_trainer_app/Trainer_screens/TrainerHome.dart';
import 'package:singapore_trainer_app/screens/admin_screens/AdminHome.dart';
import '../Views/login_view.dart';
import 'Learner_add_rating.dart';
import 'Learner_calenders.dart';
import 'Learner_class_details.dart';
import 'Learner_profile.dart';
import 'Lerner_notifications.dart';
import 'learner_chating.dart';
import 'learner_time_management.dart';
import 'leraner_dashboard.dart';

class LearnerHome extends StatefulWidget {
  const LearnerHome({super.key});

  @override
  State<LearnerHome> createState() => _LearnerHomeState();
}

class _LearnerHomeState extends State<LearnerHome> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> tabs = [
    LearnerServicePage(),
    ChatingLearner(),
    LearnerAddRating(),
    LernerCalendarPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: selectedIndex == 0
          ? AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF659F62),
        toolbarHeight: 70.h, // Use ScreenUtil for height
        title: Text(
          "LEARNER HOME",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.sp, // Use ScreenUtil for font size
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(10.w), // Use ScreenUtil for padding
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LearnerNotificationPage(),
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
          : null,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            SizedBox(height: 20.h), // Use ScreenUtil for height
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF659F62)),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const learner_profile(),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 40, // No ScreenUtil needed for this specific case
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                  ),
                  SizedBox(height: 10.h), // Use ScreenUtil for height
                  Text(
                    "LEARNER MENU",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp, // Use ScreenUtil for font size
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: Text("Dashboard", style: TextStyle(fontSize: 16.sp)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LearnerDashboard(),
                  ),
                );
              },
            ),
            ListTile(
              leading: FaIcon(Icons.timelapse),
              title: Text("Time Management", style: TextStyle(fontSize: 16.sp)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimeManagementPage(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 370.h,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your login page widget
                );

              },
            ),
            // SizedBox(
            //   height: 200,
            //   child: ListTile(
            //     leading: const Icon(Icons.logout),
            //     title: const Text("Logout"),
            //     onTap: () {
            //       Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(builder: (context) => LoginPage()), // Replace with your login page widget
            //       );
            //
            //     },
            //   ),
            // ),
            // ListTile(
            //   leading: const Icon(Icons.settings),
            //   title: Text("Trainer", style: TextStyle(fontSize: 16.sp)),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const Trainer_home(),
            //       ),
            //     );
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.settings),
            //   title: Text("Admin", style: TextStyle(fontSize: 16.sp)),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const AdminHome(),
            //       ),
            //     );
            //   },
            // ),
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
        iconSize: 30.sp, // Use ScreenUtil for icon size
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
            icon: const Icon(Icons.person_search),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 14.sp), // Use ScreenUtil for font size
            ),
            activeColor: const Color(0xFF659F62),
            inactiveColor: Colors.black,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.chat),
            title: Text(
              'Chat',
              style: TextStyle(fontSize: 14.sp), // Use ScreenUtil for font size
            ),

            activeColor: const Color(0xFF659F62),
            inactiveColor: Colors.black,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.rate_review),
            title: Text(
              'Rating',
              style: TextStyle(fontSize: 14.sp), // Use ScreenUtil for font size
            ),

            activeColor: const Color(0xFF659F62),
            inactiveColor: Colors.black,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.calendar_month),
            title: Text(
              'Calendar',
              style: TextStyle(fontSize: 14.sp), // Use ScreenUtil for font size
            ),
            activeColor: const Color(0xFF659F62),
            inactiveColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
