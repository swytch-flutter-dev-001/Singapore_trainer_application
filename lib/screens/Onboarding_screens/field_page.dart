import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:singapore_trainer_app/Trainer_screens/trainer_signup.dart';

import '../../Learner_screens/Learner_signup.dart';

class FieldPage extends StatelessWidget {
  const FieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              const Color(0xFF659F62), // Dark Green
              const Color(0xFF92C287), // Medium Green
              const Color(0xFFCDEAC0), // Light Green
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 80.h),

              // Logo/Image with Animation
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: SizedBox(
                  height: 150.h,
                  width: 200.w,
                  child: Image.asset("assets/images/Singapore Trainers-2.png"),
                ),
              ),
              SizedBox(height: 20.h),

              // Curved White Container with Buttons
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45.r),
                    topRight: Radius.circular(45.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30.r),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40.h),

                      // Conditioner Text with FadeIn Animation
                      FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: Text(
                          "Declare I'm a",
                          style: TextStyle(
                            color: const Color(0xFF659F62),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),

                      // First Button with Animation
                      FadeInUp(
                        duration: const Duration(milliseconds: 1400),
                        child: MaterialButton(
                          elevation: 5,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TrainerSignIn(),
                              ),
                            );

                            print("Trainer role selected");
                          },
                          height: 45.h,
                          color: const Color(0xFF659F62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: Text(
                              "TRAINER",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Second Button with Animation
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: MaterialButton(
                          elevation: 5,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LearnerSignIn(),
                              ),
                            );

                            print("Learner role selected");
                          },
                          height: 45.h,
                          color: const Color(0xFF659F62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: Text(
                              "LEARNER",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Admin Login Button with Animation
                      // FadeInUp(
                      //   duration: const Duration(milliseconds: 1800),
                      //   child: MaterialButton(
                      //     onPressed: () {
                      //       print("Admin role selected");
                      //     },
                      //     height: 50.h,
                      //     color: Colors.red.shade400,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(50.r),
                      //     ),
                      //     child: Center(
                      //       child: Text(
                      //         "Admin Login",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 16.sp,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
