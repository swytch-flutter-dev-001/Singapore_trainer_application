// models/navigation_item_model.dart
import 'package:flutter/cupertino.dart';

class NavigationItem {
  final String title;
  final IconData icon;
  final String route;

  NavigationItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}