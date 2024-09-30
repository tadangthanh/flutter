import 'package:flutter/material.dart';

void main() {
  runApp(OnTapProvider());
}

class OnTapProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Provider'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () {
                    print(Scaffold.of(context));
                  },
                  child: const Text('Show snackbar'),
                ),
              ),
            ),
            FrogColor(color: Colors.black, child: Builder(
              builder: (context) {
                return Text("hello world",style: TextStyle(color: FrogColor.of(context).color),);
              }
            )),
          ],
        ),
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

  static FrogColor? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FrogColor>();
  }

  static FrogColor of(BuildContext context) {
    final FrogColor? result = maybeOf(context);
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(FrogColor oldWidget) => color != oldWidget.color;
}
