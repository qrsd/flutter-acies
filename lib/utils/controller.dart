import 'dart:async';

import '../utils/constants.dart';
import '../widgets/keys.dart';

abstract class KeyController {
  static StreamController _controller = StreamController();
  static Stream get _stream => _controller.stream;
  static StreamSubscription listen(Function handler) =>
      _stream.listen(handler as dynamic);

  static void fire(KeyButton kb) => _controller.add(kb);
  static dispose() => _controller.close();
}

abstract class Brain {
  static String _delta;
  static int _p1LP = START_LP;
  static int _p2LP = START_LP;
  static String _output;

  static StreamController _controller = StreamController();
  static Stream get _stream => _controller.stream;
  static void _fire(String delta) => _controller.add(delta);
  static StreamSubscription listen(Function handler) =>
      _stream.listen(handler as dynamic);

  static StreamController _passLP1 = StreamController();
  static Stream get p1Stream => _passLP1.stream;
  static StreamController _passLP2 = StreamController();
  static Stream get p2Stream => _passLP2.stream;

  static dispose() {
    _passLP1.close();
    _passLP2.close();
    _controller.close();
  }

  static process(KeyButton kb) {
    if (kb.value.op != null) {
      if (kb.value.op == 'clr') {
        _clear();
      } else {
        _lpCalc(kb.value.op);
      }
    } else {
      _integer(kb.value.key);
    }
  }

  static void _clear() {
    _delta = null;
    _output = _delta;
    _fire(_output);
  }

  static void _integer(String val) {
    _delta = _delta == null ? val : _delta + val;
    if (_delta.length > 7) {
      _delta = _delta.substring(0, 7);
    }
    _output = _delta;
    _fire(_output);
  }

  static void _lpCalc(String operation) {
    if (_delta != null) {
      if (operation.contains('0')) {
        switch (operation) {
          case 'add0':
            _p1LP += int.parse(_delta);
            break;
          case 'min0':
            _p1LP -= int.parse(_delta);
            break;
          case 'hlf0':
            //_p1LP -= int.parse(_delta);
            break;
        }
        _passLP1.add(_p1LP);
      } else {
        switch (operation) {
          case 'add1':
            _p2LP += int.parse(_delta);
            break;
          case 'min1':
            _p2LP -= int.parse(_delta);
            break;
          case 'hlf1':
            //_p1LP -= int.parse(_delta);
            break;
        }
        _passLP2.add(_p2LP);
      }
    }
    _clear();
  }
}
