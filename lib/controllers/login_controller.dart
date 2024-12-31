import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:singapore_trainer_app/Learner_screens/Learner_home.dart';
import 'package:singapore_trainer_app/screens/admin_screens/admin_home.dart';
import 'package:singapore_trainer_app/services/login_service.dart';
import 'package:flutter/material.dart';

class LoginController {
  Future<void> login(BuildContext context, String email, String password) async {
    try {
      await loginUser(
        email: email,
        password: password,
        showMessage: (message) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
        },
        onLoginSuccess: (token) {
          try {
            Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

            if (decodedToken.containsKey('role')) {
              String role = decodedToken['role'];
              if (role == 'learner') {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>const Learner_home()));
              } else if (role == 'trainer') {
                Navigator.pushReplacementNamed(context, '/trainer');
              } else if (role == 'admin') {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminHome()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Unknown role')));
              }
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid token: $e')));
          }
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $e')));
    }
  }
}
