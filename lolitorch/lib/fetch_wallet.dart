import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lolitorch/get_token_from_storage.dart';



Future<WalletInfo> fetchWallet() async {
  final String? token = await getTokenFromStorage();
  final response = await http.get(
    Uri.parse('http://192.168.31.20:80/GetWalletInfo'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return WalletInfo.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load wallet info');
  }
}

class WalletInfo {
  final String walletName;
  final double walletBalance;
  final String keyPhrase;

  WalletInfo({required this.walletName, required this.walletBalance, required this.keyPhrase});

  factory WalletInfo.fromJson(Map<String, dynamic> json) {
    return WalletInfo(
      walletName: json['walletName'],
      walletBalance: json['walletBalance'],
      keyPhrase: json['keyPhrase'],
    );
  }
}
