import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> registerUser(String username, String password , String email) async {
    final response = await http.post(
      Uri.parse('http://192.168.31.20:80/Register'), // замени на фактический адрес сервера
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': username,
        'password': password,
        'email': email,
      }),
    );
    return response.statusCode;
  }


//172.20.10.2 mobile
//192.168.31.20 home
