import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../utils/constants.dart';
import './bloc.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  static String _delta;
  static int _p1LP;
  static int _p2LP;

  CalculatorBloc() {
    _p1LP = START_LP;
    _p2LP = START_LP;
  }

  @override
  CalculatorState get initialState => CalculatorInitial();

  @override
  Stream<CalculatorState> mapEventToState(
    CalculatorEvent event,
  ) async* {
    if (event is IntegerEvent) {
      yield* _mapIntegerEventToState(event);
    } else if (event is ClearEvent) {
      yield* _mapClearEventToState();
    } else if (event is CalculationEvent) {
      yield* _mapCalculationEventToState(event);
    }
  }

  Stream<CalculatorState> _mapIntegerEventToState(IntegerEvent event) async* {
    String val = event.value.key;
    _delta = _delta == null ? val : _delta + val;
    if (_delta.length > 7) {
      _delta = _delta.substring(0, 7);
    }
    yield MiddleUpdate(_delta);
  }

  Stream<CalculatorState> _mapClearEventToState() async* {
    _delta = null;
    yield CalculatorInitial();
  }

  Stream<CalculatorState> _mapCalculationEventToState(
      CalculationEvent event) async* {
    String val = event.value.key;
    if (_delta != null || val.contains('hlf')) {
      if (val.contains('0')) {
        switch (val) {
          case 'add0':
            _p1LP += int.parse(_delta);
            break;
          case 'min0':
            _p1LP -= int.parse(_delta);
            if (_p1LP < 0) _p1LP = 0;
            break;
          case 'hlf0':
            _p1LP ~/= 2;
            break;
        }
        yield P1LPUpdate(_p1LP);
      } else {
        switch (val) {
          case 'add1':
            _p2LP += int.parse(_delta);
            break;
          case 'min1':
            _p2LP -= int.parse(_delta);
            if (_p2LP < 0) _p2LP = 0;
            break;
          case 'hlf1':
            _p2LP ~/= 2;
            break;
        }
        yield P2LPUpdate(_p2LP);
      }
    }
    _delta = null;
  }
}
