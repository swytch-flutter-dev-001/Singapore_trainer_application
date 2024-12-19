import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrainerCertificationsPage extends StatelessWidget {
  const TrainerCertificationsPage({super.key});

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
              SizedBox(height: 20.h),

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
                      SizedBox(height: 10.h),

                      // Conditioner Text with FadeIn Animation
                      Text(
                        "Declare Your Certificate",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(right: 150),
                        child: Text("Trainer Certificates"),
                      ),
                      SizedBox(height: 5),

                      // First Button with Animation
                      FadeInUp(
                        duration: const Duration(milliseconds: 1400),
                        child: MaterialButton(
                          elevation: 5,
                          onPressed: () {
                            // Add action for Swimming certificate
                          },
                          height: 45.h,
                          color: const Color(0xFF659F62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Swimming Certificate",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
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
                            // Add action for Tennis certificate
                          },
                          height: 45.h,
                          color: const Color(0xFF659F62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Tennis Certificate",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      // Third Button with Animation
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: MaterialButton(
                          elevation: 5,
                          onPressed: () {
                            // Add action for Soccer certificate
                          },
                          height: 45.h,
                          color: const Color(0xFF659F62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Soccer Certificate",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      // Fourth Button with Animation
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: MaterialButton(
                          elevation: 5,
                          onPressed: () {
                            // Add action for Cricket certificate
                          },
                          height: 45.h,
                          color: const Color(0xFF659F62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Cricket Certificate",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),

                      // Fifth Button with Animation
                      FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: MaterialButton(
                          elevation: 5,
                          onPressed: () {
                            // Add action for Hockey certificate
                          },
                          height: 45.h,
                          color: const Color(0xFF659F62),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              SizedBox(width: 15.w),
                              Text(
                                "Hockey Certificate",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            onPressed: () {



                            },
                            height: 40.h,

                            color: Color(0xFF659F62),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Center(
                              child: Text(
                                "CONTINUE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              ),
                            ),
                          ),
                        ],
                      ),


                      // Sixth Button with Animation

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
