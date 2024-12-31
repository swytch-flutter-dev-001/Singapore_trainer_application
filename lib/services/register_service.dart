import 'dart:convert';
import 'package:http/http.dart' as http;

import '../api_keys/const_api.dart';

var regApi = "$apiBaseUrl/v1/user/register"; // Registration API endpoint

// A method to register a user with the provided details
Future<void> registerUser({
  required String fullName,
  required String username,
  required String email,
  required String phone,
  required String ccode, // Expecting phone to already include the country code
  required String password,
  required String role,
  required Function(String) showMessage, // Show message callback
}) async {
  try {
    // Prepare the data to send in the request body
    Map<String, dynamic> requestBody = {
      'fullName': fullName,
      'username': username,
      'email': email,
      'phone': phone,
      'ccode': ccode, // Send full phone number (country code + phone)
      'password': password,
      'role': role, // Include role in the payload
    };

    // Log request for debugging
    print("Requesting to: $regApi");
    print("Request body: ${json.encode(requestBody)}");

    // Send the POST request to the backend
    final response = await http.post(
      Uri.parse(regApi),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody), // Encode the data as JSON
    );

    // Log response for debugging
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    // Check the status code of the response
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Successfully registered
      Map<String, dynamic> responseData = json.decode(response.body);
      showMessage("Registration successful: ${responseData['message']}");
    } else {
      // Something went wrong, handle error message from API
      Map<String, dynamic> errorData = json.decode(response.body);
      showMessage("Error: ${errorData['message'] ?? "Registration failed!"}");
    }
  } catch (error) {
    // Handle errors (e.g., no internet connection, server errors)
    showMessage("Error: $error");
  }
}
