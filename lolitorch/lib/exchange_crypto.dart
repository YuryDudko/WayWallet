import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lolitorch/get_token_from_storage.dart';

Future<int> exchangeCrypto(String cryptocurrencyAbbreviationFirst, double exchangeAmountFirst, String cryptocurrencyAbbreviationSecond, double exchangeAmountSecond) async {
  final String? token = await getTokenFromStorage();
  final response = await http.post(
    Uri.parse('http://192.168.31.20:80/Exchange'), // замените на фактический адрес сервера
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'CryptocurrencyAbbreviationFirst': cryptocurrencyAbbreviationFirst,
      'ExchangeAmountFirst': exchangeAmountFirst,
      'CryptocurrencyAbbreviationSecond': cryptocurrencyAbbreviationSecond,
      'ExchangeAmountSecond': exchangeAmountSecond,
    }),
  );

  return response.statusCode;
}
