import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiBaseUrl = "https://singapore-trainers.bellpepper.site"; // Replace with actual API base URL

// Login API endpoint
final String loginApi = "$apiBaseUrl/v1/user/login"; //endpoints of login

// Function to login user
Future<void> loginUser({
  required String usernameOrEmail,
  required String password,
  required Function(String) showMessage,
  required Function(String) onLoginSuccess,
}) async {
  try {
    Map<String, dynamic> requestBody = {
      'usernameOrEmail': usernameOrEmail,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(loginApi),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      String token = responseData['token']; // Adjust based on your backend's response
      showMessage("Login successful!");
      onLoginSuccess(token);
    } else {
      Map<String, dynamic> errorData = json.decode(response.body);
      showMessage("Login failed: ${errorData['message'] ?? "Invalid credentials"}");
    }
  } catch (error) {
    showMessage("Error: $error");
  }
}

// Fetch user role API endpoint
final String userRoleApi = "$apiBaseUrl/v1/user/role";

Future<String> fetchUserRole(String token) async {
  final response = await http.get(
    Uri.parse(userRoleApi),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = json.decode(response.body);
    return responseData['role']; // Adjust based on API response
  } else {
    throw Exception("Failed to fetch role");
  }
}
