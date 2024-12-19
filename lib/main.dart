import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:singapore_trainer_app/screens/admin_screens/admin_login.dart';
import 'package:singapore_trainer_app/screens/Onboarding_screens/field_page.dart';
import 'package:singapore_trainer_app/screens/Onboarding_screens/login_page.dart';
import 'package:singapore_trainer_app/screens/Onboarding_screens/register_page.dart';
import 'package:singapore_trainer_app/screens/Onboarding_screens/pageview.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690), // Adjust based on your design
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Trainer App',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          initialRoute: '/',
          routes: {
            '/pageview':(context)=>LoginPage(),
            '/': (context) => SportsPageView(),
            '/register': (context) => FieldPage(),

          },
        );
      },
    );
  }
}
