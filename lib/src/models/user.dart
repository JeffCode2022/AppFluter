// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:delivery_autonoma/src/models/rol.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String id = '';
  String? name;
  String? lastname;
  String? email;
  String? phone;
  String? password;
  String? sessionToken;
  String? image;
  List<Rol> roles;
  List<User> toList = [];

  User({
    this.id = '',
    this.name,
    this.lastname,
    this.email,
    this.phone,
    this.password,
    this.sessionToken,
    this.image,
    this.roles = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] is int ? json["id"].toString() : json["id"] as String? ?? '',
        name: json["name"] ?? '',
        lastname: json["lastname"] ?? '',
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        password: json["password"],
        sessionToken: json["session_token"],
        image: json["image"] ?? '',
        roles: json["roles"] == null
            ? []
            : List<Rol>.from(json["roles"].map((model) => Rol.fromJson(model))),
      );
 

 void fromJsonList(List<dynamic> jsonList) {
    // ignore: unnecessary_null_comparison
    if (jsonList == null) return;
    for (var item in jsonList) {
      User user = User.fromJson(item);
      toList.add(user);
    }
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "password": password,
        "session_token": sessionToken,
        "image": image,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
      };
}
