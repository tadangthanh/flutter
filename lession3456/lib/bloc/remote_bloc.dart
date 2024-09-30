import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'remote_event.dart';
import 'remote_state.dart';
const String VOLUME = 'volume';
const String CHANEL = 'chanel';
class RemoteBloc {
  var state = RemoteState(70, 1);


  _init() async {
    final prefs = await SharedPreferences.getInstance();
    state = RemoteState(prefs.getInt(VOLUME) ?? 50, prefs.getInt(CHANEL) ?? 1);
    stateController.sink.add(state);
  }
  // tạo 2 controller
  // 1 cái quản lý event, đảm nhận nhiệm vụ nhận event từ UI
  final eventController = StreamController<RemoteEvent>();

  // 1 cái quản lý state, đảm nhận nhiệm vụ truyền state đến UI
  final stateController = StreamController<RemoteState>();

  RemoteBloc() {
    _init();
    // lắng nghe khi eventController push event mới
    eventController.stream.listen((RemoteEvent event) {
      // người ta thường tách hàm này ra 1 hàm riêng và đặt tên là: mapEventToState
      // đúng như cái tên, hàm này nhận event xử lý và cho ra output là state

      if (event is IncrementEvent) {
        // nếu eventController vừa add vào 1 IncrementEvent thì chúng ta xử lý tăng âm lượng
        state = RemoteState(state.volume + event.increment, state.chanel);
        _saveCounter();
      } else if (event is DecrementEvent) {
        // xử lý giảm âm lượng
        state = RemoteState(state.volume - event.decrement, state.chanel);
        _saveCounter();
      } else if (event is IncrementChanelEvent) {
        state = RemoteState(state.volume, state.chanel + event.incrementChanel);
        _saveCounter();
      } else if (event is DecrementChanelEvent) {
        state = RemoteState(state.volume, state.chanel - event.decrementChanel);
        _saveCounter();
      } else {
        // xử lý mute
        state = RemoteState(0, state.chanel);
        _saveCounter();
      }

      // add state mới vào stateController để bên UI nhận được
      stateController.sink.add(state);
    });
  }

  // khi không cần thiết thì close tất cả controller
  void dispose() {
    _saveCounter();
    stateController.close();
    eventController.close();
  }
  _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(VOLUME, state.volume);
    prefs.setInt(CHANEL, state.chanel);
  }
}
