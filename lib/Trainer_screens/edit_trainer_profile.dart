import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditTrainerProfile extends StatefulWidget {
  const EditTrainerProfile({super.key});

  @override
  State<EditTrainerProfile> createState() => _EditTrainerProfileState();
}

class _EditTrainerProfileState extends State<EditTrainerProfile> {
  final _formKey = GlobalKey<FormState>();

  // Initial values for fields
  String name = "Tyson";
  String email = "tyson@example.com";
  String phone = "+65 1234 5678";
  String experience = "5 Years";
  String specialization = "Strength Training";

  final Color primaryColor = const Color(0xFF659F62);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(

              colors: [

                Colors.white,
                Colors.white ,
              ],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 10.h),

              // Page Heading

              // Form Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Form(
                  key: _formKey,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      // Profile Picture and Name
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: const NetworkImage("https://via.placeholder.com/150"),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Editable Fields
                      _buildEditableField("Name", name, (value) {
                        if (value!.isEmpty) {
                          return "Name cannot be empty";
                        }
                        return null;
                      }, (value) => name = value!),
                      SizedBox(height: 10.h),
                      _buildEditableField("Email", email, (value) {
                        if (value!.isEmpty || !value.contains("@")) {
                          return "Enter a valid email";
                        }
                        return null;
                      }, (value) => email = value!),
                      SizedBox(height: 10.h),
                      _buildEditableField("Phone", phone, (value) {
                        if (value!.isEmpty || value.length < 8) {
                          return "Enter a valid phone number";
                        }
                        return null;
                      }, (value) => phone = value!),
                      SizedBox(height: 10.h),
                      _buildEditableField("Experience", experience, (value) {
                        if (value!.isEmpty) {
                          return "Experience cannot be empty";
                        }
                        return null;
                      }, (value) => experience = value!),
                      SizedBox(height: 10.h),
                      _buildEditableField("Specialization", specialization, (value) {
                        if (value!.isEmpty) {
                          return "Specialization cannot be empty";
                        }
                        return null;
                      }, (value) => specialization = value!),

                      SizedBox(height: 30.h),

                      // Save Changes Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.pop(context, {
                                "name": name,
                                "email": email,
                                "phone": phone,
                                "experience": experience,
                                "specialization": specialization,
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            "Save Changes",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for creating editable fields
  Widget _buildEditableField(
      String label,
      String initialValue,
      String? Function(String?) validator,
      void Function(String?) onSaved) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5.h),
        TextFormField(
          initialValue: initialValue,
          validator: validator,
          onSaved: onSaved,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: primaryColor),
            filled: true,
            fillColor: primaryColor.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
