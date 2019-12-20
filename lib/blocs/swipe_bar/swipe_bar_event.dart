import 'package:equatable/equatable.dart';

/// Abstact of swipe bar events.
abstract class SwipeBarEvent extends Equatable {
  /// Constructor
  const SwipeBarEvent();

  @override
  List<Object> get props => [];
}

/// Event fires when the swipe bar is moving.
class SwipeBarMovingEvent extends SwipeBarEvent {
  /// [offsetDelta] is the change in offset as it's moving.
  final double offsetDelta;

  /// Constructor
  const SwipeBarMovingEvent(this.offsetDelta);

  @override
  List<double> get props => [offsetDelta];
}

/// Event fires when swipe bar needs to be reset to initial.
class SwipeBarResetEvent extends SwipeBarEvent {}

/// Event fires when swipe bar is tapped.
class SwipeBarTapEvent extends SwipeBarEvent {}
