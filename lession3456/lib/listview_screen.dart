import 'dart:math';

import 'package:flutter/material.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ListViewScreenState();
  }
// const ListViewScreen({super.key});
}

class ListViewScreenState extends State<ListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List View"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              Flexible(
                child: SizedBox(
                  height: 150,
                  child: ListView(
                    // padding: const EdgeInsets.all(8),
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
                height: 10,
              ),
              Flexible(child: SizedBox(height: 150, child: buildListView2())),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context, rootNavigator: true).pop(context);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      ),
                      child: const Text("Go to screen 1"),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      entries.add("${entries.length + 1}");
                      final random = Random();
                      final int randomNumber = random.nextInt(9) * 100;
                      colorCodes.add(randomNumber);
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
                    child: const Text(
                      "Add item to list view",
                      textAlign: TextAlign.center,
                    ),
                  )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: ElevatedButton(
                      onPressed: () {
                        if (entries.isNotEmpty) {
                          setState(() {});
                          entries.removeLast();
                          colorCodes.removeLast();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                      ),
                      child: const Text(
                        "Remove item to list view",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
                ],
              )
            ],
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.navigation),
      ),
    );
  }

  List<String> entries = <String>['1', '2', '3'];
  List<int> colorCodes = <int>[600, 500, 100];

  Widget buildListView2() {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
        // padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Notification'),
                        content: Text('Click item ${entries[index]}'),
                        actions: [
                          TextButton(
                            child: const Text('Đóng'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
            },
            child: SizedBox(
              height: 50,
              // color: Colors.teal[colorCodes[index]],
              child: Center(child: Text("Item ${entries[index]}")),
            ),
          );
        });
  }
}
