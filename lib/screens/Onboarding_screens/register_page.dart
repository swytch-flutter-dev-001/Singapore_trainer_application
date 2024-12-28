import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import '../../services/api_service.dart'; // Ensure this import is correct for your API service
import 'identity_register.dart';
import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  final String role;

  // Constructor to accept role
  RegistrationPage({required this.role});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool showPassword = false; // Toggle password visibility

  // Form validation and state management
  final _formKey = GlobalKey<FormState>();
  String? _fullName, _username, _email, _phoneNumber, _password, _confirmPassword;
  bool _isLoading = false;

  // Toggle password visibility
  void togglePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  // Register function
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      // Ensure passwords match
      if (_password != _confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Call the registerUser function from API service
      try {
        await registerUser(
          fullName: _fullName!,
          username: _username!,
          email: _email!,
          phoneNumber: _phoneNumber!,
          password: _password!,
          role: widget.role,
          showMessage: (message) {
            // Handle showing the message (SnackBar, Dialog)
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          },
        );

      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $error')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
              // Logo
              Padding(
                padding: EdgeInsets.all(20),
                child: SizedBox(
                  height: 150.h,
                  width: 200.w,
                  child: Image.asset("assets/images/Singapore Trainers-2.png"),
                ),
              ),
              SizedBox(height: 20.h),
              // Registration Form
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
                          "REGISTER AS ${widget.role.toUpperCase()}",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        // Full Name Input
                        _buildInputField("Full Name", (value) => _fullName = value),
                        // Username Input
                        _buildInputField("Username", (value) => _username = value),
                        // Email Input
                        _buildInputField("Email", (value) => _email = value, inputType: TextInputType.emailAddress),
                        // Phone Number Input
                        _buildInputField("Phone Number", (value) => _phoneNumber = value, inputType: TextInputType.phone),
                        // Password Input
                        _buildPasswordField("Password", (value) => _password = value),
                        // Confirm Password Input
                        _buildPasswordField("Confirm Password", (value) => _confirmPassword = value),
                        SizedBox(height: 30.h),
                        // Register Button
                        FadeInUp(
                          duration: Duration(milliseconds: 1600),
                          child: _isLoading
                              ? CircularProgressIndicator()
                              : MaterialButton(
                            onPressed: _register,
                            height: 50.h,
                            color: Color(0xFF659F62),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Text(
                                ("REGISTER AS ${widget.role}").toUpperCase(),
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
                        // Login Link
                        FadeInUp(
                          duration: Duration(milliseconds: 1700),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: Text(
                              'Already have an account? Login',
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
                color: Color(0x50659F62),
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(
                color: Color(0x50659F62),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(
                color: Color(0xFF659F62),
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          ),
          onSaved: onSaved,
          validator: (value) => value!.isEmpty ? 'Enter your $hintText' : null,
        ),
      ),
    );
  }

  // Helper method to build password input field
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
          obscureText: !showPassword, // Toggle password visibility
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(
                color: Color(0x50659F62),
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(
                color: Color(0x50659F62),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(
                color: Color(0xFF659F62),
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            suffixIcon: IconButton(
              onPressed: togglePassword,
              icon: Icon(
                size: 16,
                showPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
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
