import 'package:equatable/equatable.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();

  @override
  List<Object> get props => [];
}

class TimerPauseEvent extends TimerEvent {}

class TimerResetEvent extends TimerEvent {
  final bool matchReset;

  const TimerResetEvent(this.matchReset);
}

class TimerResumeEvent extends TimerEvent {}

class TimerSnackBarEvent extends TimerEvent {}

class TimerStartEvent extends TimerEvent {
  final int duration;

  const TimerStartEvent(this.duration);
}

class TimerTickEvent extends TimerEvent {
  final int duration;

  const TimerTickEvent(this.duration);

  @override
  List<int> get props => [duration];
}
