import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var myData = MyModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<String>( // cai provider nay boc cai provider duoi
          create: (context) => "Xinchao buoi 12 -13 ",
        ),
        ChangeNotifierProvider<MyModel>(
          create: (context) => MyModel(),
          child: MaterialApp(
            home: _buildHomeScreen(),
          ),
        )
      ],
      child: MaterialApp(
        home: _buildHomeScreen(),
      ),
    );
    // return Provider<String>(
    //   create: (context) => "Xinchao buoi 12 -13 ",
    //   child: ChangeNotifierProvider<MyModel>(
    //     create: (context) => MyModel(),
    //     child: MaterialApp(
    //       home: _buildHomeScreen(),
    //     ),
    //   ),
    // );
  }
}

_buildHomeScreen() {
  return Scaffold(
    appBar: AppBar(title: const Text('My App')),
    backgroundColor: Colors.grey,
    body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          color: Colors.green[200],
          // hamm nay se rebuild lai ke ca ko dung toi data cua provider
          // child: Consumer<MyModel>(builder: (context, myModal, child) {
          //   return ElevatedButton(
          //       onPressed: () {
          //         myModal.doSomething();
          //         myModal.notifyListeners();
          //       },
          //       child: const Text("do some thing"));
          // }),
          //doan nay se k rebuild lai nut elevatedButton
          // child: ElevatedButton(
          //     onPressed: () {
          //       myData.doSomething();
          //     },
          //     child: Text("doSomething")),
          child: Builder(builder: (BuildContext context) {
            return ElevatedButton(
                onPressed: () {
                  //listen de false de no k goi lai ham build trong statefulwidget
                  Provider.of<MyModel>(context, listen: false).doSomething();
                  String msg = Provider.of<String>(context, listen: false);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(msg)));
                },
                child: Text("doSomething"));
          }),
        ),
        Container(
          padding: const EdgeInsets.all(35),
          color: Colors.blue[200],
          child: Consumer<MyModel>(
            builder: (context, mymodel, child) {
              return Text(mymodel.text);
            },
          ),
        ),
      ],
    ),
  );
}

class MyModel extends ChangeNotifier {
  String text = "Hello";

  void doSomething() {
    if (text == "Hello") {
      text = "World";
    } else {
      text = "Hello";
    }
    notifyListeners();
  }
}
