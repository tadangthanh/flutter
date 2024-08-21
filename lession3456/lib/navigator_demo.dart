import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(NavigatorDemo());
}

class NavigatorDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Navigator demo",
      home: NavigatorHome(),
      // neu o day tim thay se nhay vao day truoc con k thi nhay vao ham onGenerate
      routes: <String, WidgetBuilder>{
        '/screen2': (context) => Screen2(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/screen2") {
          return MaterialPageRoute<void>(
              settings: settings,
              builder: (BuildContext context) {
                return Screen2();
              });
        } else {
          return null;
        }
      },
    );
  }
}

class NavigatorHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavigatorHomeState();
  }
}

class NavigatorHomeState extends State<NavigatorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Navigator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Screen2(),
                      ),
                    );
                  },
                  child: const Text(
                    "cach 1",
                    style: TextStyle(fontSize: 30),
                  )),
              Divider(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/screen2");
                  },
                  child: const Text(
                    "cach 2",
                    style: TextStyle(fontSize: 30),
                  )),
              Divider(),
              ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.pushReplacementNamed(
                        context, "/screen2",
                        arguments: "ok em,");
                    print(result);
                  },
                  child: const Text(
                    "cach 3",
                    style: TextStyle(fontSize: 30),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  final Object? param;

  const Screen2({super.key, this.param});

  @override
  Widget build(BuildContext context) {
    final _param = ModalRoute.of(context)?.settings.arguments as String?;

    return PopScope(
      canPop: true, // neu de false thi an nut return cua may se k ve dc, con btn tu tao thi dc
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        // if (!Navigator.canPop(context)) {
        //   SystemNavigator.pop();
        // }
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text(
          "Man hinh 2",
        )),
        body: Center(
          child: Column(
            children: [
              Text("param value :$_param"),
              ElevatedButton(
                  onPressed: () async {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context, "vai ca lol");
                    } else {
                      SystemNavigator.pop();
                    }
                  },
                  child: const Text(
                    "tro ve man hinh cu",
                    style: TextStyle(fontSize: 30),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
