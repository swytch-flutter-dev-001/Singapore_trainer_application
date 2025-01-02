class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class LoginResponse {

  final String status;
  final String token;
  final String role;
  final String? message;

  LoginResponse({
    required this.status,
    required this.token,
    required this.role,
    this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'] ?? '',
      token: json['token'] ?? '',
      role: json['role'] ?? '',
      message: json['message'],
    );
  }
}
