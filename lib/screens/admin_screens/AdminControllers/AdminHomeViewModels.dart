import 'package:flutter/material.dart';

import '../../../Views/login_view.dart';
import '../../../utils/TrainerInsightPage.dart';
import '../AdminModels/AdminUserModels.dart';
import '../AdminModels/Routers_Navigation.dart';
import '../Master_data_admin.dart';
import '../admin_add_notifications.dart';
import '../admin_profile.dart';

class AdminHomeViewModel extends ChangeNotifier {
  int _selectedIndex = 0;
  AdminUser? _currentAdmin;
  List<NavigationItem> _drawerItems = [];

  int get selectedIndex => _selectedIndex;
  AdminUser? get currentAdmin => _currentAdmin;
  List<NavigationItem> get drawerItems => _drawerItems;

  AdminHomeViewModel() {
    _initializeData();
  }

  void _initializeData() {
    // Initialize admin data
    _currentAdmin = AdminUser(
      name: "ADMIN MENU",
      profileImage: 'assets/profile.jpg',
    );

    // Initialize drawer items
    _drawerItems = [
      NavigationItem(
        title: "Dashboard",
        icon: Icons.dashboard,
        route: '/dashboard',
      ),
      NavigationItem(
        title: "Insights",
        icon: Icons.insights,
        route: '/insights',
      ),
      NavigationItem(
        title: "Reports",
        icon: Icons.report_sharp,
        route: '/reports',
      ),
      NavigationItem(
        title: "Actions",
        icon: Icons.call_to_action,
        route: '/actions',
      ),
      NavigationItem(
        title: "Certificates",
        icon: Icons.picture_as_pdf,
        route: '/certificates',
      ),
      NavigationItem(
        title: "Logout",
        icon: Icons.logout,
        route: '/login',
      ),
    ];
  }

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void navigateToNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminAddNotification(),
      ),
    );
  }

  void navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminProfileEditPage(),
      ),
    );
  }

  void handleDrawerNavigation(BuildContext context, String route) {
    switch (route) {
      case '/dashboard':
        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminMDMPage()));
        break;
      case '/insights':
        Navigator.push(context, MaterialPageRoute(builder: (context) => InsightPage()));
        break;
    // Add other cases for remaining routes
      case '/login':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
        break;
    }
  }
}
