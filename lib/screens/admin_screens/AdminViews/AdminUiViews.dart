import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../AdminControllers/AdminHomeViewModels.dart';
import '../admin_chat.dart';
import '../admin_tabs.dart';
import '../trainers_learners_data_tabs.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdminHomeViewModel(),
      child: AdminHomeScreen(),
    );
  }
}

class AdminHomeScreen extends StatelessWidget {
  final List<Widget> _tabs = [
    AdminTabs(),
    trainers_learners_data(),
    AdminChat(),
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AdminHomeViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context, viewModel),
      drawer: _buildDrawer(context, viewModel),
      body: _tabs.elementAt(viewModel.selectedIndex),
      bottomNavigationBar: _buildBottomNav(context, viewModel),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context, AdminHomeViewModel viewModel) {
    if (viewModel.selectedIndex == 2) return null;

    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
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
          padding: EdgeInsets.all(10.sp),
          child: IconButton(
            onPressed: () => viewModel.navigateToNotifications(context),
            icon: const Icon(Icons.notification_add_outlined),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context, AdminHomeViewModel viewModel) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(height: 20.h),
          _buildDrawerHeader(context, viewModel),
          ...viewModel.drawerItems.map((item) => ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            onTap: () => viewModel.handleDrawerNavigation(context, item.route),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context, AdminHomeViewModel viewModel) {
    return DrawerHeader(
      decoration: const BoxDecoration(color: Color(0xFF659F62)),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => viewModel.navigateToProfile(context),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(viewModel.currentAdmin?.profileImage ?? ''),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            viewModel.currentAdmin?.name ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context, AdminHomeViewModel viewModel) {
    return Container(
      height: 80.h,
      child: FlashyTabBar(
        selectedIndex: viewModel.selectedIndex,
        backgroundColor: Colors.white,
        iconSize: 30.sp,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onItemSelected: viewModel.updateSelectedIndex,
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.person_search),
            title: const Text('Home'),
            activeColor: Color(0xFF659F62),
            inactiveColor: Colors.black,
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
    );
  }
}