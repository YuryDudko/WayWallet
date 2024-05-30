import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lolitorch/get_token_from_storage.dart';

class TransactionHistory {
  final String transactionType;
  final DateTime transactionDate;
  final String cryptoAbbreviation;
  final double amount;
  final String address;
  final double equivalentAmount;

  TransactionHistory({
    required this.transactionType,
    required this.transactionDate,
    required this.cryptoAbbreviation,
    required this.amount,
    required this.address,
    required this.equivalentAmount,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) {
    return TransactionHistory(
      transactionType: json['transactionType'],
      transactionDate: DateTime.parse(json['transactionDate']),
      cryptoAbbreviation: json['cryptoAbbreviation'],
      amount: json['amount'],
      address: json['address'],
      equivalentAmount: json['equivalentAmount'],
    );
  }
}

Future<List<TransactionHistory>> fetchTransactionHistory() async {
  final String? token = await getTokenFromStorage();
  final response = await http.get(
    Uri.parse('http://192.168.31.20:80/GetTransactionHistory'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    List<TransactionHistory> history = body.map((dynamic item) => TransactionHistory.fromJson(item)).toList();
    return history;
  } else {
    throw Exception('Failed to load transaction history');
  }
}