class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final User user;

  LoginResponse({required this.accessToken, required this.refreshToken, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String username;
  final String role;

  User({required this.id, required this.username, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      role: json['role'],
    );
  }
}
