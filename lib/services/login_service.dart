// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:jwt_decoder/jwt_decoder.dart';
// import '../api_keys/const_api.dart';
//
// const String loginApi = "$apiBaseUrl/v1/user/login"; // Login endpoint
//
// Future<void> loginUser({
//   required String email,
//   required String password,
//   required Function(String) showMessage,
//   required Function(String, String) onLoginSuccess,
//
// }) async {
//   try {
//     // Request body for login
//     Map<String, dynamic> requestBody = {
//       'email': email,
//       'password': password,
//     };
//
//     final response = await http.post(
//       Uri.parse(loginApi),
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode(requestBody),
//     );
//
//     // Check for successful login response
//     if (response.statusCode == 200) {
//       Map<String, dynamic> responseData = json.decode(response.body);
//       print("API Response: $responseData"); // Log the response for debugging
//
//       // Check for status and the presence of token
//       if (responseData['status'] == 'success' && responseData.containsKey('token')) {
//         String token = responseData['token']; // Get the token
//         String role = responseData['role'];   // Get the user role (trainer, learner, admin)
//         showMessage("Login successful!");
//
//         // Debugging prints for status and token
//         print('Status: ${responseData['status']}');
//         print('Token: $token');
//         print('Decoded Role: $role');
//
//         // Pass the token and role to the success callback
//         onLoginSuccess(token, role);
//         print("success");
//       } else {
//         print("success2");
//
//         // Show failure message for invalid login response
//         showMessage("Login failed: ${responseData['message'] ?? 'Unknown error'}");
//       }
//       print("failed");
//     }  else {
//       // Handle non-200 status code response
//       final Map<String, dynamic> errorData = json.decode(response.body);
//       showMessage("Login failed: ${errorData['message'] ?? 'Invalid credentials'}");
//     }
//   } catch (error) {
//     // Catch any errors (network issues, etc.)
//     showMessage("Error: $error");
//     print("failed 2");
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../api_keys/const_api.dart';
import '../models/LoginUser.dart';

class AuthService {
  static const String loginApi = "$apiBaseUrl/v1/user/login";

  Future<LoginResponse> login(LoginModel loginData) async {
    try {
      final response = await http.post(
        Uri.parse(loginApi),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(loginData.toJson()),
      );

      final responseData = json.decode(response.body);
      print("API Response: $responseData"); // Debug log

      if (response.statusCode == 200) {
        if (responseData['status'] == 'success' && responseData.containsKey('token')) {
          return LoginResponse.fromJson(responseData);
        } else {
          throw Exception(responseData['message'] ?? 'Unknown error');
        }
      } else {
        throw Exception(responseData['message'] ?? 'Invalid credentials');
      }
    } catch (error) {
      throw Exception('Login failed: $error');
    }
  }
}
