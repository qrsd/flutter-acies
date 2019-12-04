import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';
import '../../utils/constants.dart';

class SwipeBarBloc extends Bloc<SwipeBarEvent, SwipeBarState> {
  double _offset;

  SwipeBarBloc() {
    _offset = swipeBarStart;
  }

  @override
  SwipeBarState get initialState => SwipeBarInitial();

  @override
  Stream<SwipeBarState> mapEventToState(
    SwipeBarEvent event,
  ) async* {
    if (event is SwipeBarMovingEvent) {
      yield* _mapBarMovingEventToState(event);
    } else if (event is SwipeBarResetEvent) {
      yield* _mapBarResetEventToState();
    }
  }

  Stream<SwipeBarState> _mapBarMovingEventToState(
      SwipeBarMovingEvent event) async* {
    double eventAsDouble = event.offsetDelta * .003;
    _offset = (_offset + eventAsDouble).clamp(-.09, .0330);
    yield SwipeBarMoving(_offset);
  }

  Stream<SwipeBarState> _mapBarResetEventToState() async* {
    _offset = swipeBarStart;
    yield SwipeBarInitial();
  }
}
