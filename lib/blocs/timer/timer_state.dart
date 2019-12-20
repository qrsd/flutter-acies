import 'package:equatable/equatable.dart';

/// Abstract of timer state.
abstract class TimerState extends Equatable {
  /// [duration] required by all states.
  final int duration;

  /// Constructor
  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

/// State yielded when timer hits 0.
class TimerFinished extends TimerState {
  /// Constructor
  const TimerFinished() : super(0);
}

/// State yielded when a pause event is fired.
class TimerPaused extends TimerState {
  /// Constructor
  const TimerPaused(int duration) : super(duration);
}

/// Initial timer state.
class TimerReady extends TimerState {
  /// [matchReset] bool is used to track if timer needs to be reset after a game
  /// ends or a user forced reset.
  final bool matchReset;
  final int duration;

  /// Constructor
  TimerReady(this.duration, {this.matchReset}) : super(duration);

  @override
  List<Object> get props => [matchReset];
}

/// State yielded while timer is ticking.
class TimerRunning extends TimerState {
  /// Constructor
  const TimerRunning(int duration) : super(duration);
}

/// State yielded when a snackbar needs to be fired for timer.
class TimerSnack extends TimerState {
  /// Constructor
  const TimerSnack(int duration) : super(duration);

  @override
  List<Object> get props => [];
}
