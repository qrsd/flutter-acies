import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';
import '../../utils/constants.dart';

class SwipeBarBloc extends Bloc<SwipeBarEvent, SwipeBarState> {
  double _offset;

  SwipeBarBloc() {
    _offset = SWIPE_BAR_START;
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
    double eventAsDouble = event.offsetDelta * .004;
    _offset += eventAsDouble;
    if (_offset >= -0.005) {
      _offset = SWIPE_BAR_START;
    } else if (_offset <= SWIPE_BAR_END) {
      _offset = SWIPE_BAR_END;
    }
    yield SwipeBarMoving(_offset);
  }

  Stream<SwipeBarState> _mapBarResetEventToState() async* {
    _offset = SWIPE_BAR_START;
    yield SwipeBarInitial();
  }
}
