import 'package:flutter/material.dart';
import 'package:lession3456/ontap/ontap1.dart';

void main() {
  runApp(const ListViewHome());
}

class ListViewHome extends StatelessWidget {
  const ListViewHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListViewScreen(),
      theme: ThemeData(dividerTheme: const DividerThemeData()),
    );
  }
}

class ListViewScreen extends StatefulWidget {
  ListViewScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListViewScreenState();
  }
}

class ListViewScreenState extends State<ListViewScreen> {
  List<int> entries = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              height: 150,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    height: 50,
                    color: Colors.amber[600],
                    child: const Center(child: Text('Entry A')),
                  ),
                  Container(
                    height: 50,
                    color: Colors.amber[500],
                    child: const Center(child: Text('Entry B')),
                  ),
                  Container(
                    height: 50,
                    color: Colors.amber[100],
                    child: const Center(child: Text('Entry C')),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: listViewDynamicData(entries),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
              child: const Text(
                "navigator",
                style: TextStyle(fontSize: 30),
              )),
          ElevatedButton(
              onPressed: () {
                entries.add(entries.length + 1);
                setState(() {});
              },
              child: const Text(
                "add item",
                style: TextStyle(fontSize: 30),
              )),
          ElevatedButton(
              onPressed: () {
                entries.removeLast();
                setState(() {});
              },
              child: const Text(
                "remove item",
                style: TextStyle(fontSize: 30),
              ))
        ],
      )),
    )));
  }
}

Widget listViewDynamicData(List<int> entries) {
  final List<int> colorCodes = <int>[100, 400, 700];
  return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            print('tapped $index');
          },
          child: Container(
            height: 50,
            color: Colors.green[colorCodes[index % 3]],
            child: Center(child: Text('Entry ${entries[index]}')),
          ),
        );
      });
}
