import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lession3456/Album.dart';

class ApiService {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/albums';

  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      List<Album> albums =
          jsonList.map((json) => Album.fromJson(json)).toList();
      return albums;
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<Album> createAlbums(String title) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 201) {
      return Album(userId: 5, id: 5, title: "thanhdz");
    } else {
      throw Exception('Failed to create album');
    }
  }
}
