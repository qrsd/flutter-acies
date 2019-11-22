import 'package:equatable/equatable.dart';

abstract class SwipeBarEvent extends Equatable {
  const SwipeBarEvent();

  @override
  List<Object> get props => [];
}

class SwipeBarMovingEvent extends SwipeBarEvent {
  final double offsetDelta;

  const SwipeBarMovingEvent(this.offsetDelta);

  @override
  List<double> get props => [offsetDelta];
}

class SwipeBarResetEvent extends SwipeBarEvent {}
