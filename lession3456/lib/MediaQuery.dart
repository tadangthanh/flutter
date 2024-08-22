import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MediaQueryPage());
}

class MediaQueryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Media Query",
      home: MediaQueryHome(),
      theme: ThemeData(
          textTheme: TextTheme(displayMedium: TextStyle(fontSize: 30))),
    );
  }
}

class MediaQueryHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MediaQueryState();
  }
}

class MediaQueryState extends State<MediaQueryHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MediaQuery"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Text(
                "width= ${MediaQuery.of(context).size.width}",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "height= ${MediaQuery.of(context).size.height}",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "padding= ${MediaQuery.of(context).padding}",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "is Android= ${Platform.isAndroid}",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "bright ness= ${MediaQuery.of(context).platformBrightness}",
                style: Theme.of(context).textTheme.displayMedium,
              )
            ],
          ),
        ),
      )),
    );
  }
}
