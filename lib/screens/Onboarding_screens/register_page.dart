import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import '../../Views/login_view.dart';
import '../../services/register_service.dart'; // Ensure this import is correct for your API service
import '../../services/check_email_phone.dart';

class RegistrationPage extends StatefulWidget {
  final String role;

  RegistrationPage({required this.role});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool showPassword = false; // Toggle password visibility
  bool isEmailTaken = false;
  bool isPhoneTaken = false;

  final _formKey = GlobalKey<FormState>();
  String? _fullName, _username, _email, _password, _confirmPassword, phone, ccode;
  bool _isLoading = false;

  void togglePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  Future<void> _verifyEmailAndPhone() async {
    // Ensure email and phone are not null or empty
    if (_email == null || _email!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email')),
      );
      return;
    }

    if (phone == null || phone!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }

    setState(() {
      isEmailTaken = false;
      isPhoneTaken = false;
    });

    try {
      // Call the API to verify both email and phone
      final result = await checkEmailAndPhoneAvailability(
        email: _email!,
        phone: phone!,
      );

      // Check if the email exists
      if (result['email']['exists']) {
        setState(() {
          isEmailTaken = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email is already taken, please try a different one')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email is available')),
        );
      }

      // Check if the phone number exists
      if (result['phone']['exists']) {
        setState(() {
          isPhoneTaken = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Phone number is already taken, please try a different one')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Phone number is available')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to verify email or phone: $e')),
      );
    }
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save form field values

      setState(() {
        _isLoading = true; // Show loading indicator
      });

      // Check if passwords match
      if (_password != _confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match')),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      try {
        // Call registerUser API method
        await registerUser(
          fullName: _fullName!,
          username: _username!,
          email: _email!,
          phone: phone!,
          ccode: ccode!,
          password: _password!,
          role: widget.role,
          showMessage: (message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          },
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $error')),
        );
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    }
  }

  Widget _buildCountryCodeField(String hintText, Function(String?) onSaved,
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
          onSaved: (value) => ccode = value,
          validator: (value) => value!.isEmpty ? 'Enter country code' : null,
        ),
      ),
    );
  }

  Widget _buildPhoneField(String hintText, Function(String?) onSaved,
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
          onSaved: (value) => phone = value,
          validator: (value) => value!.isEmpty ? 'Enter phone number' : null,
        ),
      ),
    );
  }

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
          validator: (value) {
            // Check if the value is null or empty
            if (value == null || value.isEmpty) {
              return 'Enter your $hintText';
            }
            return null;
          },
        ),
      ),
    );
  }

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
                          "REGISTER AS ${widget.role.toUpperCase()}",
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        _buildInputField("Full Name", (value) => _fullName = value),
                        SizedBox(height: 10),
                        _buildInputField("Username", (value) => _username = value),
                        SizedBox(height: 10),
                        _buildInputField("Email", (value) => _email = value, inputType: TextInputType.emailAddress),
                        Padding(
                          padding: const EdgeInsets.only(left: 230),
                          child: InkWell(
                            onTap: _verifyEmailAndPhone,
                            child: Container(
                              child: Text("Verify Email"),
                            ),
                          ),
                        ),
                        _buildCountryCodeField("ccode", (value) => ccode = value, inputType: TextInputType.number),
                        SizedBox(height: 10),
                        _buildPhoneField("phone", (value) => phone = value, inputType: TextInputType.number),
                        Padding(
                          padding: const EdgeInsets.only(left: 230, bottom: 10),
                          child: InkWell(
                            onTap:_verifyEmailAndPhone,
                            child: Container(
                              child: Text("Verify number"),
                            ),
                          ),
                        ),
                        _buildPasswordField("Password", (value) => _password = value),
                        SizedBox(height: 10),
                        _buildPasswordField("Confirm Password", (value) => _confirmPassword = value),
                        SizedBox(height: 30.h),
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
                                fontWeight: FontWeight.w600,
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
}
