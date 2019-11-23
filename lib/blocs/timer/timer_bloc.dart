import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../blocs.dart';
import '../../utils/constants.dart';
import '../../utils/ticker.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final int _duration = TIMER_MINUTES * 60;
  final TopBarBloc topBarBloc;
  Ticker _ticker;

  StreamSubscription<int> _tickerSubscription;
  StreamSubscription _topBarSubscription;

  TimerBloc({@required this.topBarBloc, @required Ticker ticker}) {
    _topBarSubscription = topBarBloc.listen((state) {
      if (state is TopBarP1Win || state is TopBarP2Win) {
        add(TimerResetEvent(true));
      }
    });
    _ticker = ticker;
  }

  @override
  TimerState get initialState => TimerReady(false, _duration);

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is TimerPauseEvent) {
      yield* _mapTimerPauseEventToState(event);
    } else if (event is TimerResetEvent) {
      yield* _mapTimerResetEventToState(event);
    } else if (event is TimerResumeEvent) {
      yield* _mapTimerResumeEventToState(event);
    }
    if (event is TimerStartEvent) {
      yield* _mapTimerStartEventToState(event);
    } else if (event is TimerSnackBarEvent) {
      yield* _mapTimerSnackBarEventEventToState(event);
    } else if (event is TimerTickEvent) {
      yield* _mapTimerTickEventToState(event);
    }
  }

  Stream<TimerState> _mapTimerPauseEventToState(TimerPauseEvent event) async* {
    if (state is TimerRunning) {
      _tickerSubscription?.pause();
      yield TimerPaused(state.duration);
    }
  }

  Stream<TimerState> _mapTimerResetEventToState(TimerResetEvent event) async* {
    _tickerSubscription?.cancel();
    yield TimerReady(event.matchReset, _duration);
  }

  Stream<TimerState> _mapTimerResumeEventToState(
      TimerResumeEvent event) async* {
    if (state is TimerPaused) {
      _tickerSubscription?.resume();
      yield TimerRunning(state.duration);
    }
  }

  Stream<TimerState> _mapTimerStartEventToState(TimerStartEvent event) async* {
    yield TimerRunning(event.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTickEvent(duration)));
  }

  Stream<TimerState> _mapTimerSnackBarEventEventToState(
      TimerSnackBarEvent event) async* {
    yield TimerSnack(0);
  }

  Stream<TimerState> _mapTimerTickEventToState(TimerTickEvent event) async* {
    yield event.duration > 0 ? TimerRunning(event.duration) : TimerFinished();
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    _topBarSubscription?.cancel();
    return super.close();
  }
}
