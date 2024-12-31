import 'package:http/http.dart' as http;
import 'dart:convert';

import '../api_keys/const_api.dart';



const String verifyApiEndpoint = "$apiBaseUrl/v1/user/check";


Future<Map<String, dynamic>> checkEmailAndPhoneAvailability({
  required String email,
  required String phone,
}) async {
  try {
    // Construct the request body
    final Map<String, String> requestBody = {
      'email': email,
      'phone': phone,
    };

    // Make the POST request
    final http.Response response = await http.post(
      Uri.parse(verifyApiEndpoint),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    // Check if the response status code indicates success
    if (response.statusCode == 200) {
      // Parse and return the response data
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      // Handle non-200 responses gracefully
      throw Exception(
        'Failed to verify email or phone. '
            'Server responded with status code: ${response.statusCode}.',
      );
    }
  } catch (e) {
    // Handle any errors during the request
    print('Error occurred during email/phone verification: $e');
    throw Exception('An error occurred while verifying email or phone: $e');
  }
}
