import 'package:flutter/material.dart';

void main() {
  runApp(MyAppForLession3());
}

class MyAppForLession3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Lession3HomePage(),
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
    );
  }
}

class Lession3HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<Lession3HomePage> {
  int counter = 0;
  final myController =TextEditingController();
  void increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text("lession3"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Lession 3"),
                  Text(
                    "so lan click vao nut $counter",
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: TextField(controller: myController,)),
                      SizedBox(width: 16.0,),
                      Image.network(
                        width: 200,
                        "https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg",
                        height: 200,
                      ),
                      ElevatedButton(onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(myController.text)));
                      }, child: Text("Click me"))
                    ],
                  ),


                ],
              ),
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
      onPressed: increment,
      child: const Icon(Icons.plus_one),
    ),);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}
