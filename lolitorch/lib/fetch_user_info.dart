import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lolitorch/get_token_from_storage.dart';

Future<User> fetchUserInfo() async {
  final String? token = await getTokenFromStorage();
  final response = await http.get(
    Uri.parse('http://192.168.31.20:80/GetUserInfo'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load user info');
  }
}

class User {
  final int id;
  final String username;
  final String password;
  final String email;
  final String roleName;

  User({required this.id, required this.username, required this.password, required this.email, required this.roleName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      roleName: json['roleName'],
    );
  }
}
