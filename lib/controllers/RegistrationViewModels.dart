import 'package:flutter/material.dart';
import '../models/RegistrationModels.dart';
import '../services/check_email_phone.dart';
import '../services/register_service.dart';

class RegistrationViewModel {
  final BuildContext context;
  final ValueNotifier<bool> showPasswordNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier<bool>(false);

  String? fullName, username, email, password, confirmPassword, phone, ccode;
  bool isEmailTaken = false;
  bool isPhoneTaken = false;

  RegistrationViewModel(this.context);

  void togglePassword() {
    showPasswordNotifier.value = !showPasswordNotifier.value;
  }

  Future<void> verifyEmailAndPhone() async {
    if (email == null || email!.isEmpty) {
      _showMessage('Please enter a valid email');
      return;
    }

    if (phone == null || phone!.isEmpty) {
      _showMessage('Please enter a valid phone number');
      return;
    }

    isEmailTaken = false;
    isPhoneTaken = false;

    try {
      final result = await checkEmailAndPhoneAvailability(
        email: email!,
        phone: phone!,
      );

      if (result['email']['exists']) {
        isEmailTaken = true;
        _showMessage('Email is already taken, please try a different one');
      } else {
        _showMessage('Email is available');
      }

      if (result['phone']['exists']) {
        isPhoneTaken = true;
        _showMessage('Phone number is already taken, please try a different one');
      } else {
        _showMessage('Phone number is available');
      }
    } catch (e) {
      _showMessage('Failed to verify email or phone: $e');
    }
  }

  Future<void> register(String role) async {
    if (password != confirmPassword) {
      _showMessage('Passwords do not match');
      return;
    }

    isLoadingNotifier.value = true;

    try {
      final registrationData = RegistrationModel(
        fullName: fullName!,
        username: username!,
        email: email!,
        phone: phone!,
        ccode: ccode!,
        password: password!,
        role: role,
      );

      await registerUser(
        fullName: registrationData.fullName,
        username: registrationData.username,
        email: registrationData.email,
        phone: registrationData.phone,
        ccode: registrationData.ccode,
        password: registrationData.password,
        role: registrationData.role,
        showMessage: _showMessage,
      );
    } catch (error) {
      _showMessage('Registration failed: $error');
    } finally {
      isLoadingNotifier.value = false;
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}