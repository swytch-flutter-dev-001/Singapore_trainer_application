import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminLoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF659F62),

      body: Center(
        child: SingleChildScrollView(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Admin Email',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) => _email = value,
                      validator: (value) =>
                      value!.isEmpty ? 'Enter your admin email' : null,
                    ),
                    SizedBox(height: 16.h),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) => _password = value,
                      validator: (value) =>
                      value!.isEmpty ? 'Enter your password' : null,
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      height: 50.h ,
                      width: 200.w,
                      child: ElevatedButton(
                        style:ElevatedButton.styleFrom(
                            foregroundColor: Colors.white ,
                            backgroundColor: Colors.green.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),

                            )
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            print('Admin Logged in as $_email');
                          }
                        },
                        child: Text('Login', style: TextStyle(fontSize: 16.sp)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
