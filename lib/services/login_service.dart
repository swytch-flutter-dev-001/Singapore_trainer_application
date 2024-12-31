import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api_keys/const_api.dart';



const String loginApi = "$apiBaseUrl/v1/user/login"; // Login endpoint

Future<void> loginUser({
  required String email,
  required String password,
  required Function(String) showMessage,
  required Function(String) onLoginSuccess,
}) async {
  try {
    // Request body for login
    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(loginApi),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    // Check for successful login response
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      print("API Response: $responseData"); // Log the response for debugging

      if (responseData['status'] == 'success' && responseData.containsKey('token')) {
        String token = responseData['token']; // Get the token
        showMessage("Login successful!");

        // Pass the token to the success callback
        onLoginSuccess(token);
      } else {
        showMessage("Login failed: ${responseData['message'] ?? 'Unknown error'}");
      }
    } else {
      final Map<String, dynamic> errorData = json.decode(response.body);
      showMessage("Login failed: ${errorData['message'] ?? 'Invalid credentials'}");
    }
  } catch (error) {
    showMessage("Error: $error");
  }
}
