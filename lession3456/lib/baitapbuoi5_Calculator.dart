import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BaiTapBuoi5());
}

class BaiTapBuoi5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BaiTapBuoi5HomePage(),
    );
  }
}

class BaiTapBuoi5HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Buoi5HomePageState();
  }
}

class Buoi5HomePageState extends State<BaiTapBuoi5HomePage> {
  var myControllerA = TextEditingController();
  var myControllerB = TextEditingController();
  double result = 0;

  plus(double a, double b) {
    setState(() {});
    return a + b;
  }

  divide(double a, double b) {
    setState(() {});
    return a / b;
  }

  minus(double a, double b) {
    setState(() {});
    return a - b;
  }

  multiplied(double a, double b) {
    setState(() {});
    return a * b;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Calculator"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SafeArea(
            child: Center(
                child: Column(
              children: [
                const Image(
                  image: AssetImage("assets/casio.jpg"),
                  height: 200,
                  width: 200,
                ),
                Container(
                  width: 200,
                  child: TextField(
                    controller: myControllerA,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            gapPadding: 10),
                        hintText: "Nhập số A"),
                  ),
                ),
                Container(
                  width: 200,
                  child: TextField(
                    controller: myControllerB,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            gapPadding: 10),
                        hintText: "Nhập số B"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Kết quả : $result", style: TextStyle(fontSize: 40)),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero),
                        backgroundColor: Colors.blue, // Màu nền của nút
                      ),
                      onPressed: () {
                        try {
                          result = plus(double.parse(myControllerA.text),
                              double.parse(myControllerB.text));
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Lỗi'),
                              content: Text('Vui lòng nhập một số hợp lệ.'),
                              actions: [
                                TextButton(
                                  child: Text('Đóng'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "+",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.zero), // Màu nền của nút
                        ),
                        onPressed: () {
                          try {
                            result = minus(double.parse(myControllerA.text),
                                double.parse(myControllerB.text));
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Lỗi'),
                                content: Text('Vui lòng nhập một số hợp lệ.'),
                                actions: [
                                  TextButton(
                                    child: Text('Đóng'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Text("-",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero), // Màu nền của nút
                      ),
                      onPressed: () {
                        try {
                          result = multiplied(double.parse(myControllerA.text),
                              double.parse(myControllerB.text));
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Lỗi'),
                              content: Text('Vui lòng nhập một số hợp lệ.'),
                              actions: [
                                TextButton(
                                  child: Text('Đóng'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text("x",
                          style: TextStyle(color: Colors.white)),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero), // Màu nền của nút
                      ),
                      onPressed: () {
                        try {
                          result = divide(double.parse(myControllerA.text),
                              double.parse(myControllerB.text));
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Lỗi'),
                              content: Text('Vui lòng nhập một số hợp lệ.'),
                              actions: [
                                TextButton(
                                  child: Text('Đóng'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text(":",
                          style: TextStyle(color: Colors.white)),
                    ))
                  ],
                ),
              ],
            )),
          ),
        ));
  }
}
