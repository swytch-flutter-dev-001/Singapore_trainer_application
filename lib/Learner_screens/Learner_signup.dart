import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LearnerSignIn extends StatefulWidget {
  const LearnerSignIn({super.key});

  @override
  State<LearnerSignIn> createState() => _LearnerSignInState();
}

class _LearnerSignInState extends State<LearnerSignIn> {
  final _formKey = GlobalKey<FormState>();
  final Color primaryColor = const Color(0xFF659F62); // Your primary color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
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
          child: Column(
            children: [
              SizedBox(height: 80.h),

              // Page Heading Updated
              Text(
                "Learner Sign In",
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40.h),

              // Form Container
              Container(
                padding: EdgeInsets.all(20.r),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10.r,
                      offset:  Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TextFormField 1 - Username
                      Padding(
                        padding: const EdgeInsets.only(right: 160),
                        child: Text("Enter Username"),
                      ),
                      SizedBox(height: 5.h),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Username",
                          hintStyle: TextStyle(color: primaryColor),
                          filled: true,
                          fillColor: primaryColor.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your user name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      // TextFormField 2 - Full Name
                      Padding(
                        padding: const EdgeInsets.only(right: 150),
                        child: Text("Enter your name"),
                      ),
                      SizedBox(height: 5.h),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "FullName",
                          hintStyle: TextStyle(color: primaryColor),
                          filled: true,
                          fillColor: primaryColor.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      // TextFormField 3 - Phone
                      Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: Text("Enter your phone number"),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Phone",
                          hintStyle: TextStyle(color: primaryColor),
                          filled: true,
                          fillColor: primaryColor.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      // TextFormField 4 - Email
                      Padding(
                        padding: const EdgeInsets.only(right: 150),
                        child: Text("Enter your Email"),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: primaryColor),
                          filled: true,
                          fillColor: primaryColor.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      // TextFormField 5 - Password
                      Padding(
                        padding: const EdgeInsets.only(right: 100),
                        child: Text("Enter your password"),
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: primaryColor),
                          filled: true,
                          fillColor: primaryColor.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.h),

                      // Elevated Button - Submit
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Form Submitted Successfully!'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
