import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerFinished extends TimerState {
  const TimerFinished() : super(0);
}

class TimerPaused extends TimerState {
  const TimerPaused(int duration) : super(duration);
}

class TimerReady extends TimerState {
  final bool matchReset;
  final int duration;

  TimerReady(this.matchReset, this.duration) : super(duration);

  @override
  List<Object> get props => [matchReset];
}

class TimerRunning extends TimerState {
  const TimerRunning(int duration) : super(duration);
}

class TimerSnack extends TimerState {
  const TimerSnack(int duration) : super(duration);

  @override
  List<Object> get props => [];
}
