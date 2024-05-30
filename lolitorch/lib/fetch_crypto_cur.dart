import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lolitorch/get_token_from_storage.dart';

Future<List<CryptoCurrency>> fetchCryptocurrencies() async {
  final String? token = await getTokenFromStorage();
  final response = await http.get(
    Uri.parse('http://192.168.31.20:80/GetCryptocurrencyList'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    List<CryptoCurrency> cryptocurrencies = body.map((dynamic item) => CryptoCurrency.fromJson(item)).toList();
    return cryptocurrencies;
  } else {
    throw Exception('Failed to load cryptocurrencies');
  }
}

class CryptoCurrency {
  final int id;
  final String currencyCode;
  final String currencyName;
  final String currencyAddress;
  final double currencyAmount;

  CryptoCurrency({
    required this.id,
    required this.currencyCode,
    required this.currencyName,
    required this.currencyAddress,
    required this.currencyAmount,
  });

  factory CryptoCurrency.fromJson(Map<String, dynamic> json) {
    return CryptoCurrency(
      id: json['id'] ?? 0,
      currencyCode: json['currencyCode'] ?? '',
      currencyName: json['currencyName'] ?? '',
      currencyAddress: json['currencyAdress'] ?? '',
      currencyAmount: json['currencyAmount'] ?? 0.0,
    );
  }
}
