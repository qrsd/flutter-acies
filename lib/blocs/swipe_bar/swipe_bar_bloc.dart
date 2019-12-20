import 'dart:async';
import 'package:bloc/bloc.dart';

import '../../utils/constants.dart';
import './bloc.dart';

/// Swipe bar BLoC.
class SwipeBarBloc extends Bloc<SwipeBarEvent, SwipeBarState> {
  double _offset;

  /// Constructor
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
      yield* _mapSwipeBarMovingEventToState(event);
    } else if (event is SwipeBarResetEvent) {
      yield* _mapSwipeBarResetEventToState();
    } else if (event is SwipeBarTapEvent) {
      yield* _mapSwipeBarTapEvent();
    }
  }

  Stream<SwipeBarState> _mapSwipeBarMovingEventToState(
      SwipeBarMovingEvent event) async* {
    var eventAsDouble = event.offsetDelta * .003;
    _offset = (_offset + eventAsDouble).clamp(-.09, .0330);
    yield SwipeBarMoving(_offset);
  }

  Stream<SwipeBarState> _mapSwipeBarResetEventToState() async* {
    _offset = swipeBarStart;
    yield SwipeBarInitial();
  }

  Stream<SwipeBarState> _mapSwipeBarTapEvent() async* {
    if (_offset == -.09) {
      _offset = .0330;
    } else {
      _offset = -.09;
    }
    yield SwipeBarMoving(_offset);
  }
}
