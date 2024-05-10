import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> loginUser(String login, String password) async {
    final response = await http.post(
      
      Uri.parse('http://172.20.10.2:80/Login'), // замени на фактический адрес сервера
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'login': login,
        'password': password,
      }),
    );
    return response.statusCode;
  }