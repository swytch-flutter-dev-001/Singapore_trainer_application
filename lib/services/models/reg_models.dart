// import 'dart:convert';
//
// RegisterModel registerModelFromJson(String str) =>
//     RegisterModel.fromJson(json.decode(str));
//
// String registerModelToJson(RegisterModel data) => json.encode(data.toJson());
//
// class RegisterModel {
//   int status;
//   String message;
//   Data data;
//
//   RegisterModel({
//     required this.status,
//     required this.message,
//     required this.data,
//   });
//
//   factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
//     status: json["status"],
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   int id;
//   String username;
//   String role;
//
//   Data({
//     required this.id,
//     required this.username,
//     required this.role,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     id: json["id"],
//     username: json["username"],
//     role: json["role"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "username": username,
//     "role": role,
//   };
// }
