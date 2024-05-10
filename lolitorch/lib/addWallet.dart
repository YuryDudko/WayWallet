import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> addWallet(String walletName, String keyPhrase , String userName) async {
    final response = await http.post(
      
      Uri.parse('http://172.20.10.2:80/AddWallet'), // замени на фактический адрес сервера
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'walletName': walletName,
        'keyPhrase': keyPhrase,
        'UserName': userName,
      }),
    );
    return response.statusCode;
  }