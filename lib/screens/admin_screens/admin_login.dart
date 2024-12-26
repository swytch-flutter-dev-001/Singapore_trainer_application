import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:singapore_trainer_app/screens/admin_screens/admin_home.dart';

import '../../authentications/forgot_pass.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;
  bool showPassword = false;
  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Example role-based authentication logic
      if (_email == 'admin@gmail.com' && _password == '123') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminHome()),
        );
      }else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect username or password'),
          ),
        );
      }
    }
  }

      void togglePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          // height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color(0xFF659F62),
                Color(0xFF659F62),
                Color(0xFF659F62),
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 80.h),
                // Image Section
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    height: 150.h,
                    width: 250.w,
                    child: Image.asset(
                      "assets/images/Singapore Trainers-2.png", // Replace with your image path

                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(30.r),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Please Login",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 30.h),

                          // Email Input with Animation
                          FadeInUp(
                            duration: Duration(milliseconds: 1400),
                            child: _buildInputField(
                              "Email",
                              (value) => _email = value,
                              inputType: TextInputType.emailAddress,
                            ),
                          ),

                          // Password Input with Animation
                          FadeInUp(
                            duration: Duration(milliseconds: 1400),
                            child: _buildPasswordField(
                              "Password",
                              (value) => _password = value,
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Forgot Password
                          FadeInUp(
                            duration: Duration(milliseconds: 1500),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14.sp),
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),

                          // Login Button with Animation
                          FadeInUp(
                            duration: Duration(milliseconds: 1600),
                            child: MaterialButton(
                              onPressed:_login,
                              height: 40.h,
                              color: Color(0xFF659F62),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  "LOGIN",
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
                            height: 100.h,
                          )

                          // Form Section
                          // Container(
                          //   padding: EdgeInsets.all(24.r),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(20.r),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.black12,
                          //         blurRadius: 10.r,
                          //         offset: Offset(0, 5),
                          //       ),
                          //     ],
                          //   ),
                          //   child: Form(
                          //     key: _formKey,
                          //     child: Column(
                          //       mainAxisSize: MainAxisSize.min,
                          //       children: [
                          //         Text(
                          //           "Admin Login",
                          //           style: TextStyle(
                          //             fontSize: 22.sp,
                          //             fontWeight: FontWeight.bold,
                          //             color: Colors.black,
                          //           ),
                          //         ),
                          //         SizedBox(height: 30.h),
                          //
                          //         // Email Input with Animation
                          //         FadeInUp(
                          //           duration: Duration(milliseconds: 1400),
                          //           child: _buildInputField(
                          //             "Admin Email",
                          //                 (value) => _email = value,
                          //             inputType: TextInputType.emailAddress,
                          //           ),
                          //         ),
                          //
                          //         // Password Input with Animation
                          //         FadeInUp(
                          //           duration: Duration(milliseconds: 1400),
                          //           child: _buildPasswordField(
                          //             "Password",
                          //                 (value) => _password = value,
                          //           ),
                          //         ),
                          //
                          //         SizedBox(height: 30.h),
                          //
                          //         // Login Button with Animation
                          //         FadeInUp(
                          //           duration: Duration(milliseconds: 1600),
                          //           child: SizedBox(
                          //             height: 50.h,
                          //             width: double.infinity,
                          //             child: ElevatedButton(
                          //               style: ElevatedButton.styleFrom(
                          //                 backgroundColor: Color(0xFF659F62),
                          //                 foregroundColor: Colors.white,
                          //                 shape: RoundedRectangleBorder(
                          //                   borderRadius: BorderRadius.circular(10.r),
                          //                 ),
                          //               ),
                          //               onPressed: _login,
                          //               child: Text(
                          //                 'Login',
                          //                 style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }

  // Email Input Field with Design
  Widget _buildInputField(String hintText, Function(String?) onSaved,
      {TextInputType inputType = TextInputType.text}) {
    return FadeInUp(
      duration: Duration(milliseconds: 1400),
      child: Container(
        padding: EdgeInsets.all(0.r),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Color(0x30659F62),
              blurRadius: 5.r,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: TextFormField(

          keyboardType: inputType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(
                color: Color(0x50659F62), // Border with low opacity
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(
                color: Color(0x50659F62), // Border with low opacity
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(
                color: Color(0xFF659F62), // Solid border when focused
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: 12.h, horizontal: 16.w),
          ),
          onSaved: onSaved,
          validator: (value) => value!.isEmpty ? 'Enter your $hintText' : null,
        ),
      ),
    );
  }
  // Password Input Field with Design
  Widget _buildPasswordField(String hintText, Function(String?) onSaved) {
    return FadeInUp(
      duration: Duration(milliseconds: 1400),
      child: Container(
        padding: EdgeInsets.all(0.r),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Color(0x30659F62),
              blurRadius: 5.r,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: TextFormField(

          obscureText: !showPassword,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(
                color: Color(0x50659F62), // Border with low opacity
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(
                color: Color(0x50659F62), // Border with low opacity
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(
                color: Color(0xFF659F62), // Solid border when focused
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: 12.h, horizontal: 16.w),
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: IconButton(
                onPressed: togglePassword,
                icon: Icon(
                  showPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                  size: 16,
                ),
              ),
            ),
          ),
          onSaved: onSaved,
          validator: (value) => value!.isEmpty ? 'Enter your $hintText' : null,
        ),
      ),
    );
  }
}