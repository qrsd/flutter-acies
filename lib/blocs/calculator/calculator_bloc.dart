import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';
import '../blocs.dart';
import '../../utils/constants.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  static int _p1LP;
  static int _p2LP;
  static String _delta;

  final TopBarBloc topBarBloc;

  StreamSubscription topBarSubscription;

  CalculatorBloc({@required this.topBarBloc}) {
    topBarSubscription = topBarBloc.listen((state) {
      if (state is TopBarP1Win || state is TopBarP2Win) {
        add(CalculatorResetEvent());
      }
    });
    _p1LP = startLifePoints;
    _p2LP = startLifePoints;
  }

  @override
  CalculatorState get initialState => CalculatorInitial();

  @override
  Stream<CalculatorState> mapEventToState(
    CalculatorEvent event,
  ) async* {
    if (event is CalculatorCalculationEvent) {
      yield* _mapCalculatorCalculationEventToState(event);
    } else if (event is CalculatorClearEvent) {
      yield* _mapCalculatorClearEventToState();
    } else if (event is CalculatorIntegerEvent) {
      yield* _mapCalculatorIntegerEventToState(event);
    } else if (event is CalculatorResetEvent) {
      yield* _mapCalculatorResetEventToState();
    } else if (event is CalculatorResumeEvent) {
      yield* _mapCalculatorResumeEventToState(event);
    }
  }

  Stream<CalculatorState> _mapCalculatorCalculationEventToState(
      CalculatorCalculationEvent event) async* {
    String val = event.value.key;
    String delta;
    if (_delta != null || val.contains('hlf')) {
      if (val.contains('0')) {
        switch (val) {
          case 'add0':
            delta = _delta;
            _p1LP += int.parse(_delta);
            if (_p1LP >= 99999) _p1LP = 99999;
            break;
          case 'min0':
            delta = _delta;
            _p1LP -= int.parse(_delta);
            if (_p1LP < 0) _p1LP = 0;
            break;
          case 'hlf0':
            _p1LP ~/= 2;
            delta = _p1LP.toString();
            break;
        }
        yield CalculatorP1LPUpdate(
            _p1LP, delta, val.contains('add') ? true : false);
      } else {
        switch (val) {
          case 'add1':
            delta = _delta;
            _p2LP += int.parse(_delta);
            if (_p2LP >= 99999) _p2LP = 99999;
            break;
          case 'min1':
            delta = _delta;
            _p2LP -= int.parse(_delta);
            if (_p2LP < 0) _p2LP = 0;
            break;
          case 'hlf1':
            _p2LP ~/= 2;
            delta = _p2LP.toString();
            break;
        }
        yield CalculatorP2LPUpdate(
            _p2LP, delta, val.contains('add') ? true : false);
      }
    }
    _delta = null;
  }

  Stream<CalculatorState> _mapCalculatorClearEventToState() async* {
    _delta = null;
    yield CalculatorClear();
  }

  Stream<CalculatorState> _mapCalculatorIntegerEventToState(
      CalculatorIntegerEvent event) async* {
    String val = event.value.key;
    if (val.contains('0') && _delta == null) {
      _delta = null;
    } else {
      _delta = '${_delta ?? ''}$val';
      if (_delta.length > 5) {
        _delta = _delta.substring(0, 5);
      }
    }
    yield CalculatorMiddleUpdate(_delta);
  }

  Stream<CalculatorState> _mapCalculatorResetEventToState() async* {
    _delta = null;
    _p1LP = 8000;
    _p2LP = 8000;
    yield CalculatorInitial();
  }

  Stream<CalculatorState> _mapCalculatorResumeEventToState(
      CalculatorResumeEvent event) async* {
    if (event.player == playerOneVal) {
      yield CalculatorResume(event.player, _p1LP);
    } else {
      yield CalculatorResume(event.player, _p2LP);
    }
  }

  @override
  Future<void> close() {
    topBarSubscription.cancel();
    return super.close();
  }
}
