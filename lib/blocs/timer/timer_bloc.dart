import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../utils/ticker.dart';
import '../../utils/constants.dart';
import './bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  final int _duration = TIMER_MINUTES * 60;
  StreamSubscription<int> _tickerSubscription;

  TimerBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker;

  @override
  TimerState get initialState => TimerReady(_duration);

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerStartEvent) {
      yield* _mapTimerStartEventToState(event);
    } else if (event is TimerTickEvent) {
      yield* _mapTimerTickEventToState(event);
    } else if (event is TimerPauseEvent) {
      yield* _mapTimerPauseEventToState(event);
    } else if (event is TimerResetEvent) {
      yield* _mapTimerResetEventToState(event);
    } else if (event is TimerResumeEvent) {
      yield* _mapTimerResumeEventToState(event);
    } else if (event is TimerSnackBarEvent) {
      yield* _mapTimerSnackBarEventEventToState(event);
    }
  }

  Stream<TimerState> _mapTimerStartEventToState(TimerStartEvent event) async* {
    yield TimerRunning(event.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTickEvent(duration)));
  }

  Stream<TimerState> _mapTimerTickEventToState(TimerTickEvent event) async* {
    yield event.duration > 0 ? TimerRunning(event.duration) : TimerFinished();
  }

  Stream<TimerState> _mapTimerPauseEventToState(TimerPauseEvent event) async* {
    if (state is TimerRunning) {
      _tickerSubscription?.pause();
      yield TimerPaused(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResetEventToState(event) async* {
    _tickerSubscription?.cancel();
    yield TimerReady(_duration);
  }

  Stream<TimerState> _mapTimerResumeEventToState(
      TimerResumeEvent event) async* {
    if (state is TimerPaused) {
      _tickerSubscription?.resume();
      yield TimerRunning(state.duration);
    }
  }

  Stream<TimerState> _mapTimerSnackBarEventEventToState(
      TimerSnackBarEvent event) async* {
    yield TimerSnack(0);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
