import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("TESSSSSSSSSSSSS");
    return Text("ok em");
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  Color frogColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  const snackBar =
                      SnackBar(content: Text("Noi dung thong bao"));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text("show snack bar")),
          ),
          FrogColor(
            color: frogColor,
            child: Builder(
              builder: (BuildContext innerContext) {
                return Text(
                  'Hello Frog',
                  style: TextStyle(color: FrogColor.of(innerContext)?.color),
                );
              },
            ),
          ),
          FrogColor(color: Colors.red, child: Test()),// ham test rebuild lai khi frogColor thay doi
          ElevatedButton(
              onPressed: () {
                setState(() {
                  if (frogColor == Colors.green) {
                    frogColor = Colors.red;
                  } else {
                    frogColor = Colors.green;
                  }
                });
              },
              child: const Text("change color")),
        ],
      ),
    );
  }
}

class FrogColor extends InheritedWidget {
  const FrogColor({
    super.key,
    required this.color,
    required super.child,
  });

  final Color color;

  static FrogColor? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FrogColor>();
  }

  @override
  bool updateShouldNotify(FrogColor oldWidget) => color != oldWidget.color;
}
