import 'package:flutter/material.dart';
import 'package:lession3456/Album.dart';
import 'package:lession3456/apiservice.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Album> albums = [];
  final titleController = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  Future<void> _loadAlbums() async {
    try {
      albums = await apiService.fetchAlbums();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }
  Future<void> _createAlbum(String title) async {
    try {
      final album = await apiService.createAlbums(title);
      albums.add(album);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
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
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your album title',
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _createAlbum(titleController.text);
                  },
                  child: const Text('Create Data'),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: listViewShowData(albums),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget listViewShowData(List<Album> list) {
  return ListView.builder(
    itemCount: list.length,
    itemBuilder: (context, index) {
      final album = list[index];
      return ListTile(
        title: Text(album.title),
        subtitle: Text('Album ID: ${album.id}'),
      );
    },
  );
}
