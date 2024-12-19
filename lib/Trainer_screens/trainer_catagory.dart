import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Learner_screens/Learner_signup.dart';

class Trainer_catagory extends StatelessWidget {
  const Trainer_catagory({super.key});

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
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.h),

                      // Conditioner Text with FadeIn Animation
                      Text(
                        "Register as a Trainer",
                        style: TextStyle(
                          color:  Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 25.h),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 190),
                        child: Text(" Choose Your Area"),
                      ),
                      SizedBox(
                        height: 5,
                      ),

                      // First Button with Animation
                      FadeInUp(
                        duration: const Duration(milliseconds: 1400),
                        child: MaterialButton(
                          elevation: 5,
                          onPressed: () {



                          },
                          height: 45.h,
                          color: const Color(0xFF659F62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: Text(
                              "SWIMMING",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      // Second Button with Animation
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: MaterialButton(
                          elevation: 5,
                          onPressed: () {

                          },
                          height: 45.h,
                          color: const Color(0xFF659F62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: Text(
                              "TENNIS",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: MaterialButton(
                          elevation: 5,
                          onPressed: () {

                          },
                          height: 45.h,
                          color: const Color(0xFF659F62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: Text(
                              "SOCCER",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: MaterialButton(
                          elevation: 5,
                          onPressed: () {

                          },
                          height: 45.h,
                          color: const Color(0xFF659F62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: Text(
                              "CRICKET",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: MaterialButton(
                          elevation: 5,
                          onPressed: () {

                          },
                          height: 45.h,
                          color: const Color(0xFF659F62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: Text(
                              "HOCKEY",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: MaterialButton(
                          elevation: 5,
                          onPressed: () {

                          },
                          height: 45.h,
                          color: const Color(0xFF659F62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Center(
                            child: Text(
                              "BADMINTON",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

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
