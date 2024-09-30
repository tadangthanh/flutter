import 'package:flutter/material.dart';

import 'bloc/remote_bloc.dart';
import 'bloc/remote_event.dart';
import 'bloc/remote_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = RemoteBloc(); // khởi tạo bloc  <=== new
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<RemoteState>(
          // sử dụng StreamBuilder để lắng nghe Stream <=== new
          stream: bloc.stateController.stream,
          // truyền stream của stateController vào để lắng nghe <=== new
          initialData: bloc.state,
          // giá trị khởi tạo chính là volume 70 hiện tại <=== new
          builder: (BuildContext context, AsyncSnapshot<RemoteState> snapshot) {
            return Column(
              children: [
                Text('Âm lượng hiện tại: ${snapshot.data?.volume}'),
                Text('Kêny hiện tại: ${snapshot.data?.chanel}')
              ],
            ); // update UI <=== new
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => bloc.eventController.sink.add(IncrementEvent(5)),
            // add event <=== new
            child: const Icon(Icons.volume_up),
          ),
          FloatingActionButton(
            onPressed: () => bloc.eventController.sink.add(DecrementEvent(10)),
            // add event <=== new
            child: const Icon(Icons.volume_down),
          ),
          FloatingActionButton(
            onPressed: () => bloc.eventController.sink.add(MuteEvent()),
            // add event <=== new
            child: const Icon(Icons.volume_mute),
          ),
          FloatingActionButton(
            onPressed: () => bloc.eventController.sink.add(IncrementChanelEvent(1)),
            // add event <=== new
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () => bloc.eventController.sink.add(DecrementChanelEvent(1)),
            // add event <=== new
            child: const Icon(Icons.remove),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose(); // dispose bloc <=== new
  }
}
