import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerSnack extends TimerState {
  const TimerSnack(int duration) : super(duration);

  @override
  List<Object> get props => [];
}

class TimerReady extends TimerState {
  const TimerReady(int duration) : super(duration);
}

class TimerPaused extends TimerState {
  const TimerPaused(int duration) : super(duration);
}

class TimerRunning extends TimerState {
  const TimerRunning(int duration) : super(duration);
}

class TimerFinished extends TimerState {
  const TimerFinished() : super(0);
}
