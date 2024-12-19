import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrainerSignIn extends StatefulWidget {
  const TrainerSignIn({super.key});

  @override
  State<TrainerSignIn> createState() => _TrainerSignInState();
}

class _TrainerSignInState extends State<TrainerSignIn> {
  final _formKey = GlobalKey<FormState>();
  final Color primaryColor = const Color(0xFF659F62); // Your primary color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              // Page Heading
              Text(
                "Trainer Sign In",
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
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TextFormField 1 - Username
                      const Text("Enter Username"),
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
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      // TextFormField 2 - Full Name
                      const Text("Enter Your Name"),
                      SizedBox(height: 5.h),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Full Name",
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
                      const Text("Enter Your Phone Number"),
                      SizedBox(height: 5.h),
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
                      const Text("Enter Your Email"),
                      SizedBox(height: 5.h),
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
                      const Text("Enter Your Password"),
                      SizedBox(height: 5.h),
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

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 45.h,

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
