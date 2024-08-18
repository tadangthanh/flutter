import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(BaiTapBuoi4());
}

class BaiTapBuoi4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BaiTapBuoi4HomePage(),
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
    );
  }
}

class BaiTapBuoi4HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BaiTapBuoi4HomePageState();
  }
}

class BaiTapBuoi4HomePageState extends State<BaiTapBuoi4HomePage> {
  int _counter = 0;
  late bool isSnt;
  var colors = <MaterialColor>[
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow
  ];

  void handle() {
    setState(() {
      _counter++;
    });
    if (_counter % 2 == 0) {
      Random random = Random();
      // Lấy một màu ngẫu nhiên
      colorSelected = colors[random.nextInt(colors.length)];
    }
  }

  void handleCheckSnt(){
    int n = myController.text.isNotEmpty
        ? int.parse(myController.text)
        : 0;
    if (n < 2) {
      setState(() {
        isSnt = true;
      });
      return;
    }
    for (int i = 2; i < n; ++i) {
      if (n % i == 0) {
        setState(() {
          isSnt = false;
        });
        return;
      }
    }
  }
  late MaterialColor colorSelected;
  var myController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: colorSelected,
        appBar: AppBar(
          title: Text("Bai tap ve nha buoi 4"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: SafeArea(
              child: Center(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Giá trị hiện tại : $_counter",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              ElevatedButton(
                onPressed: handle,
                child: Text("Tăng giá trị"),
              ),
              TextField(
                controller: myController,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              ElevatedButton(
                onPressed: handleCheckSnt,
                child: Text("Kiểm tra"),
              ),
              Text(isSnt
                  ? "Số ${myController.text} là số nguyên tố"
                  : "Số ${myController.text} không phải số nguyên tố")
            ],
          ))),
        ));
  }
}
