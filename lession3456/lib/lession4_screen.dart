import 'package:flutter/material.dart';

import 'listview_screen.dart';

void main() => runApp(const ExpandedApp());

class ExpandedApp extends StatelessWidget {
  const ExpandedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          dividerTheme: const DividerThemeData(
        thickness: 3,
        color: Colors.green,
      )),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Expanded Column Sample'),
        ),
        body: const ExpandedExample(),
      ),
    );
  }
}

class ExpandedExample extends StatelessWidget {
  const ExpandedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          buildStack(),
          const SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.blue,
            height: 100,
            width: 100,
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.amber,
              width: 100,
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      color: Colors.red,
                      // width: 100,
                    )),
                Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      color: Colors.blue,
                      // width: 100,
                    )),
                Flexible(
                    flex: 2,
                    child: Container(
                      color: Colors.yellow,
                      // width: 100,
                    ))
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.green,
              width: 100,
            ),
          ),
          buildDecorationText(),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListViewScreen()),
                );
              },
              child: const Text("Go to screen 2"))
        ],
      ),
    );
  }
}

Widget buildStack() {
  return Stack(
    alignment: AlignmentDirectional.center,
    children: <Widget>[
      Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
      Container(
        width: 90,
        height: 90,
        color: Colors.green,
      ),
      Positioned(
        left: 0,
        top: 90,
        child: Container(
          width: 80,
          height: 80,
          color: Colors.blue,
        ),
      ),
    ],
  );
}

Widget buildDecorationText() {
  return SizedBox(
    width: 250,
    height: 250,
    child: Stack(
      children: <Widget>[
        Container(
          width: 250,
          height: 250,
          color: Colors.white,
        ),
        Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.black.withAlpha(0),
                Colors.black12,
                Colors.black45
              ],
            ),
          ),
          child: const Text(
            'Foreground Text',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ],
    ),
  );
}
