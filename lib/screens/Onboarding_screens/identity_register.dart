import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'login_page.dart';

class IdentityRegistration extends StatefulWidget {
  @override
  State<IdentityRegistration> createState() => _IdentityRegistrationState();
}

class _IdentityRegistrationState extends State<IdentityRegistration> {
  final _formKey = GlobalKey<FormState>();

  String? _last4DigitsID, _companyName, _companyUEN, _permanentAddress;

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
              SizedBox(height: 40.h),

              // Logo Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  height: 150.h,
                  width: 200.w,
                  child: Center(
                    child: Image.asset(
                        "assets/images/Singapore Trainers-2.png"),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // Form Container
              Container(
                width: double.infinity,
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 130),
                          child: Text(
                            "Declare Your Identity",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Profile Picture Placeholder
                        _buildProfilePictureSection(),
                        SizedBox(height: 20.h),

                        // Last 4 Digits of ID
                        _buildInputFieldWithHeading(
                            "Identity Details", "Last 4 Digits Of Your ID", (
                            value) => _last4DigitsID = value),

                        // Company Name
                        _buildInputFieldWithHeading(
                            "Company Information", "Company Name", (value) =>
                        _companyName = value),

                        // Company UEN
                        _buildInputFieldWithHeading(
                            "Company UEN", "Company UEN", (value) =>
                        _companyUEN = value),

                        // Permanent Address
                        _buildInputFieldWithHeading(
                            "Permanent Address", "Permanent Address", (value) =>
                        _permanentAddress = value),

                        SizedBox(height: 30.h),

                        // Register Button
                        FadeInUp(
                          duration: Duration(milliseconds: 1600),
                          child: MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                                print(
                                    "Registered: $_last4DigitsID, $_companyName, $_companyUEN, $_permanentAddress");
                              }
                            },
                            height: 40.h,
                            color: Color(0xFF659F62),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Text(
                                "REGISTER",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
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

  // Profile Picture Section
  Widget _buildProfilePictureSection() {
    return FadeInUp(
      duration: Duration(milliseconds: 1400),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.only(right: 125),
            child: Text(
              "Create Profile Picture",
              style: TextStyle(fontSize: 15.sp, color: Colors.black),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: CircleAvatar(
              radius: 40.r,
              backgroundImage: AssetImage(
                  "assets/images/profile_placeholder.png"),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build a text input field with a heading
  Widget _buildInputFieldWithHeading(String heading, String hintText,
      Function(String?) onSaved,
      {TextInputType inputType = TextInputType.text}) {
    return FadeInUp(
      duration: Duration(milliseconds: 1400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5.h),
          Container(
            padding: EdgeInsets.all(0.r),
            margin: EdgeInsets.only(bottom: 20.h),
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
                    color: Color(0xFF659F62).withOpacity(0.3),
                    // Border color with reduced opacity
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.r),
                  borderSide: BorderSide(
                    color: Color(0xFF659F62).withOpacity(0.3),
                    // Enabled border with reduced opacity
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.r),
                  borderSide: BorderSide(
                    color: Color(0xFF659F62).withOpacity(0.5),
                    // Focused border with slightly higher opacity
                    width: 1.0,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 12.h, horizontal: 16.w),
              ),
              onSaved: onSaved,
              validator: (value) =>
              value!.isEmpty
                  ? 'Enter your $hintText'
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}