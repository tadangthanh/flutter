import 'package:flutter/material.dart';

void main() {
  runApp(BaiTapBuoi5Flex());
}

class BaiTapBuoi5Flex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BaiTapBuoi5FlexHomePage(),
    );
  }
}

class BaiTapBuoi5FlexHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BaiTapBuoi5FlexState();
  }
}

class BaiTapBuoi5FlexState extends State<BaiTapBuoi5FlexHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
              child: Text("Flex Demo - CodeFresher",
                  style: TextStyle(fontSize: 30)))),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Container(
                          width: 170,
                          child: const Image(
                              image: AssetImage("assets/mattruoc.jpg")),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Flexible(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Lập trình Flutter",
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            "Thực chiến dự án app mobile 2022",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ))
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 5,
                //   child: Container(
                //     color: Colors.green,
                //   ),
                // ),
                const Divider(
                   thickness: 5,
                  indent: 10,
                  endIndent: 10,
                  color: Colors.green,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Lập trình Android",
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            "Java + Kotlin",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          width: 170,
                          child: const Image(
                              image: AssetImage("assets/casio.jpg")),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
