import 'package:equatable/equatable.dart';

abstract class SwipeBarEvent extends Equatable {
  const SwipeBarEvent();

  @override
  List<Object> get props => [];
}

class BarMoving extends SwipeBarEvent {
  final double offsetDelta;

  const BarMoving(this.offsetDelta);

  @override
  List<double> get props => [offsetDelta];
}
