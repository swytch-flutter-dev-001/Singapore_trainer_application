import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:singapore_trainer_app/screens/Onboarding_screens/register_page.dart';
import 'package:singapore_trainer_app/screens/admin_screens/admin_home.dart';
import '../authentications/forgot_pass.dart';
import '../controllers/login_controller.dart';
import '../screens/Onboarding_screens/field_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;
  bool showPassword = false;
  bool _isLoading = false;

  LoginController _controller = LoginController();

  void togglePassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF659F62), Color(0xFF659F62), Color(0xFF659F62)],
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFF659F62),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.all(20),
              child: Image.asset("assets/images/Singapore Trainers-2.png", height: 150.h, width: 200.w),
            ),
            SizedBox(height: 80.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r)),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text("Please Login", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Colors.black)),
                      SizedBox(height: 30.h),
                      _buildInputField("Email", (value) => _email = value, inputType: TextInputType.emailAddress),
                      _buildPasswordField("Password", (value) => _password = value),
                      SizedBox(height: 20.h),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                        },
                        child: Text("Forgot Password?", style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
                      ),
                      SizedBox(height: 20.h),
                      MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setState(() {
                              _isLoading = true;
                            });
                            await _controller.login(context, _email!, _password!);
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                        height: 40.h,
                        color: Color(0xFF659F62),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        child: Center(
                          child: _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text("LOGIN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp)),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const FieldPage()));
                        },
                        child: Text('Don’t have an account? Register', style: TextStyle(fontSize: 14.sp, color: Colors.black)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String hintText, Function(String?) onSaved, {TextInputType inputType = TextInputType.text}) {
    return Container(
      padding: EdgeInsets.all(0.r),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [BoxShadow(color: Color(0x30659F62), blurRadius: 5.r, offset: Offset(0, 10))],
      ),
      child: TextFormField(
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(11.r), borderSide: BorderSide(color: Color(0x50659F62), width: 1.0)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(11.r), borderSide: BorderSide(color: Color(0x50659F62), width: 1.0)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(11.r), borderSide: BorderSide(color: Color(0xFF659F62), width: 1.5)),
          contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        ),
        onSaved: onSaved,
        validator: (value) => value!.isEmpty ? 'Enter your $hintText' : null,
      ),
    );
  }

  Widget _buildPasswordField(String hintText, Function(String?) onSaved) {
    return Container(
      padding: EdgeInsets.all(0.r),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [BoxShadow(color: Color(0x30659F62), blurRadius: 5.r, offset: Offset(0, 10))],
      ),
      child: TextFormField(
        obscureText: !showPassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(11.r), borderSide: BorderSide(color: Color(0x50659F62), width: 1.0)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(11.r), borderSide: BorderSide(color: Color(0x50659F62), width: 1.0)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(11.r), borderSide: BorderSide(color: Color(0xFF659F62), width: 1.5)),
          suffixIcon: IconButton(
            onPressed: togglePassword,
            icon: Icon(size: 16, showPassword ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        ),
        onSaved: onSaved,
        validator: (value) => value!.isEmpty ? 'Enter your $hintText' : null,
      ),
    );
  }
}