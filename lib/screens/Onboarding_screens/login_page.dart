import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:singapore_trainer_app/screens/Onboarding_screens/register_page.dart';
import '../../authentications/forgot_pass.dart';
import '../../Learner_screens/learner_home.dart';
import 'identity_register.dart';
import 'pageview.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String? _email, _password;
  bool showpassword = false;

  void tooglepassword() {
    setState(() {
      showpassword = !showpassword;
    });
  }

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
              Color(0xFF659F62), // Dark Green
              Color(0xFF92C287), // Medium Green
              Color(0xFFCDEAC0), // Light Green
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 80.h),
              Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                  height: 150.h,
                  width: 200.w,
                  child: Image.asset("assets/images/Singapore Trainers-2.png"),
                ),
              ),
              SizedBox(height: 20.h),
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

                        // Email Input
                        FadeInUp(
                          duration: Duration(milliseconds: 1400),
                          child: _buildInputField(
                            "Email",
                                (value) => _email = value,
                            inputType: TextInputType.emailAddress,
                          ),
                        ),

                        // Password Input
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
                                  builder: (context) => ForgotPasswordScreen(),
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
                        SizedBox(height: 20.h),

                        // Login Button
                        FadeInUp(
                          duration: Duration(milliseconds: 1600),
                          child: MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Learner_home(),
                                  ),
                                );
                                print("Logged in as $_email");
                              }
                            },
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
                        SizedBox(height: 12.h),

                        // Register Link
                        FadeInUp(
                          duration: Duration(milliseconds: 1700),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => IdentityRegistration(),
                                ),
                              );
                            },
                            child: Text(
                              'Don’t have an account? Register',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build a text input field
  Widget _buildInputField(String hintText, Function(String?) onSaved,
      {TextInputType inputType = TextInputType.text}) {
    return Container(
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
    );
  }


  // Helper method to build a password input field
  Widget _buildPasswordField(String hintText, Function(String?) onSaved) {
    return Container(
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
        obscureText: !showpassword,
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
              onPressed: tooglepassword,
              icon: Icon(
                showpassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                size: 16,
              ),
            ),
          ),
        ),
        onSaved: onSaved,
        validator: (value) => value!.isEmpty ? 'Enter your $hintText' : null,
      ),
    );
  }
}
