class RegistrationModel {
  final String fullName;
  final String username;
  final String email;
  final String phone;
  final String ccode;
  final String password;
  final String role;

  RegistrationModel({
    required this.fullName,
    required this.username,
    required this.email,
    required this.phone,
    required this.ccode,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'username': username,
      'email': email,
      'phone': phone,
      'ccode': ccode,
      'password': password,
      'role': role,
    };
  }
}