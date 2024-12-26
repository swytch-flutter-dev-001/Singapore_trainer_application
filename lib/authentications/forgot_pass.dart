import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  // Define your color scheme
  final Color darkGreen = Color(0xFF659F62);
  final Color mediumGreen = Color(0xFF92C287);
  final Color lightGreen = Color(0xFFCDEAC0);

  // Function to handle password reset request
  void _handleForgotPassword() {
    final String email = _emailController.text.trim();

    if (email.isEmpty) {
      // Show an error message if the email is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email address.')),
      );
      return;
    }

    // Example condition to check if the email matches a certain pattern
    if (_validateEmail(email)) {
      // Simulating sending a reset email
      setState(() {
        _isLoading = true;
      });

      // After sending the email, show a success message
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset email sent!')),
        );
        Navigator.pop(context); // Go back to the login screen after sending the email
      });
    } else {
      // If the email is not valid, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email not found or invalid format.')),
      );
    }
  }

  // Method to validate email format
  bool _validateEmail(String email) {
    // Example validation: Check if the email matches a pattern
    RegExp emailRegex = RegExp(r'^[a-zA-Z0-9]+@([a-zA-Z0-9]+\.)+[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: darkGreen,
        title: Text('FORGET PASSWORD', style: TextStyle(color: Colors.white,fontSize:18,fontWeight: FontWeight.w500)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title Text
            Text(
              'Enter your email to reset password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color:Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            // Email TextField
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter your registered email',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: mediumGreen),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color:Colors.black),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),

            SizedBox(height: 20),

            // Forgot password button
            _isLoading
                ?SpinKitFadingCube(
              color: Color(0xFF659F62),
              size: 20,
            )
                : ElevatedButton(
              onPressed: _handleForgotPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: darkGreen,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Send Reset Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Back to login text button
            TextButton(

              onPressed: () {
                Navigator.pop(context); // Navigate back to the login screen
              },
              child: Text(
                'Back to Login',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
