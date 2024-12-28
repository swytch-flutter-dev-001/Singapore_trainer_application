import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/models.dart';

Future<LoginResponse?> loginUser(String email, String password, BuildContext context) async {
  final Uri url = Uri.parse('https://singapore-trainers.bellpepper.site/v1/user/login'); // Replace with your API endpoint

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Save JWT tokens in shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('accessToken', responseData['data']['accessToken']);
      prefs.setString('refreshToken', responseData['data']['refreshToken']);

      // Optionally save user info
      prefs.setInt('userId', responseData['data']['user']['id']);
      prefs.setString('username', responseData['data']['user']['username']);
      prefs.setString('role', responseData['data']['user']['role']);

      // Return login response
      return LoginResponse.fromJson(responseData['data']);
    } else {
      final Map<String, dynamic> errorData = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorData['message'])));
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong.')));
    return null;
  }
}
