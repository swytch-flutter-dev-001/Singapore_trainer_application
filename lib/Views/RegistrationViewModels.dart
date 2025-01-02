import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import '../controllers/RegistrationViewModels.dart';
import 'login_view.dart';

class RegistrationPage extends StatefulWidget {
  final String role;
  RegistrationPage({required this.role});
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late RegistrationViewModel _viewModel;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _viewModel = RegistrationViewModel(context);
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
              borderSide: BorderSide(color: Color(0x50659F62), width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(color: Color(0x50659F62), width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11.r),
              borderSide: BorderSide(color: Color(0xFF659F62), width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          ),
          onSaved: onSaved,
          validator: (value) => value?.isEmpty ?? true ? 'Enter your $hintText' : null,
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
        child: ValueListenableBuilder<bool>(
          valueListenable: _viewModel.showPasswordNotifier,
          builder: (context, showPassword, _) {
            return TextFormField(
              obscureText: !showPassword,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.r),
                  borderSide: BorderSide(color: Color(0x50659F62), width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.r),
                  borderSide: BorderSide(color: Color(0x50659F62), width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.r),
                  borderSide: BorderSide(color: Color(0xFF659F62), width: 1.5),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: IconButton(
                    onPressed: _viewModel.togglePassword,
                    icon: Icon(
                      showPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
                      size: 16,
                    ),
                  ),
                ),
              ),
              onSaved: onSaved,
              validator: (value) => value?.isEmpty ?? true ? 'Enter your $hintText' : null,
            );
          },
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
                        _buildInputField("Full Name", (value) => _viewModel.fullName = value),
                        _buildInputField("Username", (value) => _viewModel.username = value),
                        _buildInputField("Email", (value) => _viewModel.email = value,
                            inputType: TextInputType.emailAddress),
                        Padding(
                          padding: const EdgeInsets.only(left: 230),
                          child: InkWell(
                            onTap: () => _viewModel.verifyEmailAndPhone(),
                            child: Text("Verify Email"),
                          ),
                        ),
                        _buildInputField("Country Code", (value) => _viewModel.ccode = value,
                            inputType: TextInputType.number),
                        _buildInputField("Phone", (value) => _viewModel.phone = value,
                            inputType: TextInputType.number),
                        Padding(
                          padding: const EdgeInsets.only(left: 230, bottom: 10),
                          child: InkWell(
                            onTap: () => _viewModel.verifyEmailAndPhone(),
                            child: Text("Verify number"),
                          ),
                        ),
                        _buildPasswordField("Password", (value) => _viewModel.password = value),
                        _buildPasswordField("Confirm Password",
                                (value) => _viewModel.confirmPassword = value),
                        SizedBox(height: 30.h),
                        ValueListenableBuilder<bool>(
                          valueListenable: _viewModel.isLoadingNotifier,
                          builder: (context, isLoading, child) {
                            return FadeInUp(
                              duration: Duration(milliseconds: 1600),
                              child: isLoading
                                  ? CircularProgressIndicator()
                                  : MaterialButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    _viewModel.register(widget.role);
                                  }
                                },
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
                            );
                          },
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