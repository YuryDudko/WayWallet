import 'dart:convert';
import 'package:http/http.dart' as http;

Future banUser (String username , String password) async {
  final response = await http.post(
    Uri.parse('http://172.17.101.176:80/api/auth/ban'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );
  return response.statusCode;
}