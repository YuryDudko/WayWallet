import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lolitorch/get_token_from_storage.dart';

Future<List<Network>> fetchNetworks() async {
  final String? token = await getTokenFromStorage();
  final response = await http.get(
    Uri.parse('http://192.168.31.20:80/GetNetworkInfo'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> networksJson = json.decode(response.body);
    return networksJson.map((json) => Network.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load networks');
  }
}

class Network {
  final int id;
  final String networkName;
  final double networkGas;
  final int networkLoad;

  Network({
    required this.id,
    required this.networkName,
    required this.networkGas,
    required this.networkLoad,
  });

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      id: json['id'],
      networkName: json['networkName'],
      networkGas: json['networkGas'],
      networkLoad: json['networkLoad'],
    );
  }
}
