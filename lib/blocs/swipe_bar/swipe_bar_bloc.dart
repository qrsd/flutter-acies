import 'dart:async';
import 'package:bloc/bloc.dart';

import './bloc.dart';

class SwipeBarBloc extends Bloc<SwipeBarEvent, SwipeBarState> {
  double _offset;

  SwipeBarBloc() {
    _offset = .04;
  }

  @override
  SwipeBarState get initialState => SwipeBarInitial();

  @override
  Stream<SwipeBarState> mapEventToState(
    SwipeBarEvent event,
  ) async* {
    if (event is BarMoving) {
      yield* _mapBarMovingToState(event);
    }
  }

  Stream<SwipeBarState> _mapBarMovingToState(BarMoving event) async* {
    double eventAsDouble = event.props[0] * .003;
    _offset += eventAsDouble;
    if (_offset > .04) {
      _offset = .04;
    } else if (_offset < -.09) {
      _offset = -.09;
      yield SwipeBarTop(_offset);
    } else {
      yield SwipeBarMoving(_offset);
    }
  }
}
