import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:singapore_trainer_app/screens/Onboarding_screens/register_page.dart';
import 'package:singapore_trainer_app/screens/admin_screens/admin_login.dart';
import '../../authentications/forgot_pass.dart';
import '../../Learner_screens/learner_home.dart';
import '../../Trainer_screens/trainer_home.dart';
import '../admin_screens/admin_home.dart';
import 'field_page.dart';
import 'identity_register.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String? _email, _password;
  bool showpassword = false;
  bool isAdmin = true;
  bool _isLoading = false;

  void togglePassword() {
    setState(() {
      showpassword = !showpassword;
    });
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Example role-based authentication logic
      if (_email == 'admin@gmail.com' && _password == '123') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminHome()),
        );
      } else if (_email == 'trainer@gmail.com' && _password == '123') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Trainer_home()),
        );
      } else if (_email == 'learner@gmail.com' && _password == '123') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Learner_home()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid credentials. Please try again.'),
          ),
        );
      }
    }
  }

  void _showAdminLoginDialog() {
    final TextEditingController _passcodeController = TextEditingController();
    bool _isLoading = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text('Admin Login'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isLoading)
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: SpinKitFadingCube(
                        color: Color(0xFF659F62),
                        size: 40.0,
                      ),
                    ),
                  )
                else
                  Column(
                    children: [
                      Text('Enter the admin passcode to proceed.'),
                      SizedBox(height: 10),
                      TextField(
                        controller: _passcodeController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Admin Passcode',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  setState(() => _isLoading = true); // Show loader
                  await Future.delayed(Duration(seconds: 2)); // Simulate delay

                  if (_passcodeController.text == "admin123") {
                    setState(() => _isLoading = false); // Hide loader
                    Navigator.pop(context); // Close dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminLoginPage()),
                    );
                  } else {
                    setState(() => _isLoading = false); // Hide loader
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Incorrect passcode!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text('Proceed'),
              ),
            ],
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false, // Removes back button
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide.none
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFF659F62),
              Color(0xFF659F62),
              Color(0xFF659F62),
            ],
          ),
        ),
      ),
      actions: [
        // Display admin icon only if isAdmin is true
        if (isAdmin)
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: _showAdminLoginDialog,
          ),
      ],
    ),

      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
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

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                  height: 150.h,
                  width: 200.w,
                  child: Image.asset("assets/images/Singapore Trainers-2.png"),
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
                  padding: EdgeInsets.all(20.r),
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

                        // Login Button with Animation
                        FadeInUp(
                          duration: Duration(milliseconds: 1600),
                          child: MaterialButton(
                            onPressed: _login,
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
                                  builder: (context) => RegistrationPage(),
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
                onPressed: togglePassword,
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
      ),
    );
  }
}