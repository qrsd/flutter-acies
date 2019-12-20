import 'package:equatable/equatable.dart';

/// Abstract of timer events.
abstract class TimerEvent extends Equatable {
  /// Constructor
  const TimerEvent();

  @override
  List<Object> get props => [];
}

/// Event fires when timer needs to be paused.
class TimerPauseEvent extends TimerEvent {}

/// Event fires when a timer reset action is fired.
class TimerResetEvent extends TimerEvent {
  /// [matchReset] bool is used to track if timer needs to be reset after a game
  /// ends or a user forced reset.
  final bool matchReset;

  /// Constructor
  const TimerResetEvent({this.matchReset});
}

/// Event fires when player resumes timer.
class TimerResumeEvent extends TimerEvent {}

/// Event fires when a timer snack bar event is fired.
class TimerSnackBarEvent extends TimerEvent {}

/// Event fires when timer is first started.
class TimerStartEvent extends TimerEvent {
  /// [duration] is the starting point of the timer.
  final int duration;

  /// Constructor
  const TimerStartEvent(this.duration);
}

/// Event fires every tick of the timer.
class TimerTickEvent extends TimerEvent {
  /// [duration] is the current time left.
  final int duration;

  /// Constructor
  const TimerTickEvent(this.duration);

  @override
  List<int> get props => [duration];
}
