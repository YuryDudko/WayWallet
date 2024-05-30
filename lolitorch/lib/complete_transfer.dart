import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lolitorch/get_token_from_storage.dart';

Future<int> transferMoney(String recipientAddress, String currency , String network, double amount) async {
  final String? token = await getTokenFromStorage();
  final response = await http.post(
        Uri.parse('http://192.168.31.20:80/Transfer'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'RecipientAddress': recipientAddress,
          'Currency': currency,
          'Network': network,
          'Amount': amount,
        }),
      );
  return response.statusCode;
}