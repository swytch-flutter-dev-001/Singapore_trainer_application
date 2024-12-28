import 'dart:convert';
import 'package:http/http.dart' as http;

var apiBaseUrl = "https://singapore-trainers.bellpepper.site"; // Backend URL
var regApi = "$apiBaseUrl/v1/user/register"; // Registration API endpoint

// A method to register a user with the provided details
Future<void> registerUser({
  required String fullName,
  required String username,
  required String email,
  required String phoneNumber,
  required String password,
  required String role,
  required Function(String) showMessage,  // Show message callback (could be a Snackbar or dialog)
}) async {
  try {
    // Prepare the data to send in the request body
    Map<String, dynamic> requestBody = {
      'fullName': fullName,
      'username': username,
      'email': email,
      'phone': phoneNumber,
      'password': password,
      // 'role': role,
    };

    // Send the POST request to the backend
    final response = await http.post(
      Uri.parse(regApi),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody), // Encode the data as JSON
    );

    // Check the status code of the response
    if (response.statusCode == 200) {
      // Successfully registered
      Map<String, dynamic> responseData = json.decode(response.body);
      showMessage("Registration successful: ${responseData['message']}");
    } else {
      // Something went wrong
      Map<String, dynamic> errorData = json.decode(response.body);
      showMessage("Error: ${errorData['message'] ?? "Registration failed!"}");
    }
  } catch (error) {
    // Handle error (e.g., no internet connection, server errors)
    showMessage("Error: $error");
  }
}
