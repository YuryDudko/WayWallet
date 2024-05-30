import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lolitorch/get_token_from_storage.dart';

Future<List<News>> fetchNews() async {
  final String? token = await getTokenFromStorage();
  final response = await http.get(
    Uri.parse('http://192.168.31.20:80/GetNewsList'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    return body.map((dynamic item) => News.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load news');
  }
}

Future<List<News>> fetchModerationNews() async {
  final String? token = await getTokenFromStorage();
  final response = await http.get(
    Uri.parse('http://192.168.31.20:80/GetModerationNews'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    return body.map((dynamic item) => News.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load moderation news');
  }
}

Future<void> acceptNews(int newsId) async {
  final String? token = await getTokenFromStorage();
  final response = await http.post(
    Uri.parse('http://192.168.31.20:80/AcceptNews'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: json.encode({'newsId': newsId}),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to accept news');
  }
}

Future<List<News>> fetchNoModerationNews() async {
  final String? token = await getTokenFromStorage();
  final response = await http.get(
    Uri.parse('http://192.168.31.20:80/GetNotModerationNews'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    return body.map((dynamic item) => News.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load not moderation news');
  }
}

Future<void> createNews(String title, String description) async {
  final String? token = await getTokenFromStorage();
  final response = await http.post(
    Uri.parse('http://192.168.31.20:80/CreateNews'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'description': description,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to create news');
  }
}

class News {
  final int id;
  final String title;
  final String description;
  final DateTime createdAt;
  final int userId;

  News({required this.id, required this.title, required this.description, required this.createdAt, required this.userId});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      userId: json['userId'],
    );
  }
}
