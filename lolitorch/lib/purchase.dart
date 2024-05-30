import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lolitorch/get_token_from_storage.dart';
import 'package:lolitorch/fetch_crypto_cur.dart';

Future<int> purchaseCrypto(double purchaseRateValue, double orderAmount, String receiverAddress, String cryptoAbbreviation) async {
  final String? token = await getTokenFromStorage();
  final response = await http.post(
    Uri.parse('http://192.168.31.20:80/Purchase'), // замените на фактический адрес сервера
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'PurchaseRateValue': purchaseRateValue,
      'OrderAmount': orderAmount,
      'ReceiverAdress': receiverAddress,
      'CryptoAbbreviation': cryptoAbbreviation,
    }),
  );

  return response.statusCode;
}

Future<String> getCryptoAddressByAbbreviation(String abbreviation) async {
  List<CryptoCurrency> cryptocurrencies = await fetchCryptocurrencies();
  CryptoCurrency? currency = cryptocurrencies.firstWhere((crypto) => crypto.currencyCode == abbreviation);
  return currency.currencyAddress;
}