import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://res.cloudinary.com/dtljonz0f/image/upload/c_auto,ar_1:1,w_3840,g_auto/f_auto/q_auto/v1/gc-v1/new-york-pass/attractions/b1akrc5erpuc0rjirtxq?_a=BAVARSDW0'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            margin:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("New york"),
                const Text(
                  "lorem ipsum dolor sit amet consectetur"
                      " adipiscing elit sed do eiusmod tempor incididunt ut labore"
                      " et dolore magna aliqua ut enim ad minim veniam quis nostrud"
                      " exercitation ullamco laboris nisi ut aliquip ex ea commodo"
                      " consequat duis aute irure dolor in reprehenderit in voluptate"
                      " velit esse cillum dolore eu fugiat nulla pariatur excepteur"
                      " sint occaecat cupidatat non proident sunt in culpa qui officia"
                      " deserunt mollit anim id est laborum",
                  style: TextStyle(color: Colors.black),
                ),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: const Text("back",style: TextStyle(fontSize: 30),))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
