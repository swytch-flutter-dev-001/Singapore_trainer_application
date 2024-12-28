import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    // Delay of 3 seconds before navigating to the next screen
    Future.delayed(Duration(seconds: 6), () {
      // Navigating to the next screen (replace '/pageview' with your route name)
      Navigator.pushReplacementNamed(context, '/pageview');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Lottie animation
        child: Lottie.asset(
          height: 150,
          width: 300,
          "assets/animations/Anime.json.json", // Correct path for the Lottie file
        ),
      ),
    );
  }
}
