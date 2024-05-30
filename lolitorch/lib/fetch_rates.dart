import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lolitorch/get_token_from_storage.dart';

Future<List<Rate>> fetchRates() async {
  final String? token = await getTokenFromStorage();
  final responseNew = await http.post(
    Uri.parse('http://192.168.31.20:80/UpdateRates'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );
  if (responseNew.statusCode == 200){
    final response = await http.get(
      Uri.parse('http://192.168.31.20:80/GetRates'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Rate> rates = body.map((dynamic item) => Rate.fromJson(item)).toList();
      return rates;
    } else {
      throw Exception('Failed to load rates');
    }
  } else {
      throw Exception('Failed to update rates');
  }

  
}

class Rate {
  final int coinId;
  final String symbol;
  final String name;
  final int rank;
  final double priceUsd;
  final double percentChange24h;
  final double percentChange1h;
  final double percentChange7d;
  final double priceBtc;

  Rate({
    required this.coinId,
    required this.symbol,
    required this.name,
    required this.rank,
    required this.priceUsd,
    required this.percentChange24h,
    required this.percentChange1h,
    required this.percentChange7d,
    required this.priceBtc,
  });

  factory Rate.fromJson(Map<String, dynamic> json) {
    return Rate(
      coinId: json['coinId'] ?? 0,
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      rank: json['rank'] ?? 0,
      priceUsd: json['priceUsd']?.toDouble() ?? 0.0,
      percentChange24h: json['percentChange24h']?.toDouble() ?? 0.0,
      percentChange1h: json['percentChange1h']?.toDouble() ?? 0.0,
      percentChange7d: json['percentChange7d']?.toDouble() ?? 0.0,
      priceBtc: json['priceBtc']?.toDouble() ?? 0.0,
    );
  }
}