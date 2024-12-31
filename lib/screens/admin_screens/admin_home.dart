import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:singapore_trainer_app/screens/admin_screens/trainers_learners_data_tabs.dart';
import 'package:singapore_trainer_app/utils/certificate_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Trainer_screens/Notification_trainer.dart';

import '../../Views/login_view.dart';
import '../../utils/TrainerInsightPage.dart';
import '../../utils/action_page.dart';
import '../../utils/reports_page.dart';
import 'Master_data_admin.dart';
import 'admin_add_notifications.dart';
import 'admin_chat.dart';
import 'admin_profile.dart';
import 'admin_tabs.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int selectedIndex = 0;

  final List<Widget> tabs = [
    AdminTabs(),
    trainers_learners_data(),
    AdminChat(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: selectedIndex == 2
          ? null
          : AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF659F62),
        toolbarHeight: 70.h,
        title: const Text(
          "ADMIN HOME",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.all(10.sp),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminAddNotification(),
                  ),
                );
              },
              icon: const Icon(Icons.notification_add_outlined),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
             SizedBox(height: 20.h),
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF659F62)),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminProfileEditPage(),
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
                    "ADMIN MENU",
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
              title: const Text("Dashboard"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminMDMPage(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.insights),
              title: const Text("Insights"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InsightPage(),
                  ),
                );

              },
            ),
            ListTile(
              leading: const Icon(Icons.report_sharp),
              title: const Text("Reports"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportPage(),
                  ),
                );

              },
            ),
            ListTile(
              leading: const Icon(Icons.call_to_action),
              title: const Text("Actions"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminActionsPage(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text("Certificates"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>CertificatePage (name: "ASHIQUE.K", role: 'TRAINER', courseOrExperience: 'SWIMMING'),
                  ),
                );
              },
            ),
            SizedBox(
              height: 250.h,
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



          ],
        ),
      ),
      body: tabs.elementAt(selectedIndex),
      bottomNavigationBar: Container(
        height: 80.h ,
        child: FlashyTabBar(

          selectedIndex: selectedIndex,
          backgroundColor: Colors.white, // Dark Green
          iconSize: 30.sp,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onItemSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: [
            FlashyTabBarItem(

              icon: const Icon(Icons.person_search),
              title: const Text('Home'),
              activeColor: Color(0xFF659F62),     // Light Green for active state
              inactiveColor: Colors.black,             // White for inactive state
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.data_exploration),
              title: const Text('Data'),
              activeColor: Color(0xFF659F62),
              inactiveColor: Colors.black,
            ),
            FlashyTabBarItem(

              icon: const Icon(Icons.chat),
              title: const Text('Chat'),
              activeColor: Color(0xFF659F62),
              inactiveColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
