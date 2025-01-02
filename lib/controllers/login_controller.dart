// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:singapore_trainer_app/Learner_screens/LearnerHome.dart';
// import 'package:singapore_trainer_app/Trainer_screens/TrainerHome.dart';
// import 'package:singapore_trainer_app/screens/admin_screens/AdminHome.dart';
// import 'package:singapore_trainer_app/services/login_service.dart';
// import 'package:flutter/material.dart';
//
// class LoginController {
//   Future<void> login(BuildContext context, String email, String password) async {
//     try {
//       await loginUser(
//         email: email,
//         password: password,
//         showMessage: (message) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//         },
//         onLoginSuccess: (token, role) {
//           try {
//             print("failed error");
//             // Debugging print statements
//             print('Token: $token');  // Print the token to check if it's correct
//             print('Decoded Role: $role');  // Print the role to check if it's correct
//
//             // Proceed with role-based navigation
//             if (role == 'learner') {
//               Navigator.pushReplacementNamed(context, '/LearnerHome');
//               print("failed 1");
//             } else if (role == 'trainer') {
//               print("failed 2");
//               Navigator.pushReplacementNamed(context, '/TrainerHome');
//             } else if (role == 'admin') {
//               print("failed 3");
//               Navigator.pushReplacementNamed(context, '/AdminHome');
//             } else {
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unknown role: $role')));
//             }
//           } catch (e) {
//             // Catch any errors related to decoding or navigation
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error decoding token: $e')));
//           }
//         },
//       );
//     } catch (e) {
//       // Handle any errors during the login process
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $e')));
//     }
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singapore_trainer_app/Learner_screens/LearnerHome.dart';
import 'package:singapore_trainer_app/Trainer_screens/TrainerHome.dart';
import 'package:singapore_trainer_app/screens/admin_screens/AdminHome.dart';
import '../models/LoginUser.dart';
import '../screens/admin_screens/AdminViews/AdminUiViews.dart';
import '../services/login_service.dart';


class LoginViewModel {
  final BuildContext context;
  final AuthService _authService = AuthService();


  final ValueNotifier<bool> showPasswordNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);

  String? email;
  String? password;

  LoginViewModel(this.context);

  void togglePassword() {
    showPasswordNotifier.value = !showPasswordNotifier.value;
  }

  Future<void> login() async {
    if (email == null || password == null) {
      _showMessage('Please enter email and password');
      return;
    }

    isLoadingNotifier.value = true;

    try {
      final loginData = LoginModel(
        email: email!,
        password: password!,
      );

      final user = await _authService.login(loginData);

      // Save user data locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_token', user.token);
      await prefs.setString('user_role', user.role);
      // await prefs.setString('user_id', user.id);

      // Navigate based on role
      _navigateBasedOnRole(user.role);
    } catch (error) {
      _showMessage('Login failed: $error');
    } finally {
      isLoadingNotifier.value = false;
    }
  }

  void _navigateBasedOnRole(String role) {
    switch (role.toLowerCase()) {
      case 'trainer':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>TrainerHome()));
        break;
      case 'learner':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LearnerHome()));
        break;
      case 'admin':
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHome()));
        break;
      default:
        _showMessage('Unknown role: $role');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}