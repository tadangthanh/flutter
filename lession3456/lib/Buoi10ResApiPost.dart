import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class Album {
  final int id;
  final String title;

  const Album({
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String title,
      } =>
        Album(
          id: id,
          title: title,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class _MyAppState extends State<MyApp> {
  Future<Album>? futureAlbum;
  var myController = TextEditingController();
  String? myTitle;
  @override
  @override
  Widget build(BuildContext context) {
    Widget bodyContainer;
    if (futureAlbum == null) {
      bodyContainer = buildColumn();
    } else {
      bodyContainer = buildFutureBuilder();
    }
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Column(
          children: [
            Center(
              child: bodyContainer,
            ),
            Text("mytitle: $myTitle"),
          ],
        ),
      ),
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data!.title);
          } else if (snapshot.hasError) {
            return Text("error: ${snapshot.error}");
          }
          return const CircularProgressIndicator();
        });
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: myController,
          style: const TextStyle(fontSize: 30),
          decoration: const InputDecoration(
            labelText: "nhap title",
          ),
        ),
        ElevatedButton(
            onPressed: () {
              createAlbum(myController.text).then((onValue){
                setState(() {
                  myTitle=onValue.title;
                });
              });
              // setState(() {
              //   futureAlbum = createAlbum(myController.text);
              // });
            },
            child: const Text("Add")),
      ],
    );
  }
}

Future<Album> createAlbum(String title) async {
  final response = await http.post(
    Uri.parse("https://jsonplaceholder.typicode.com/albums"),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({"title": title}),
  );
  if (response.statusCode == 201) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}
