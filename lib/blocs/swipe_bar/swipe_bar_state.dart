import 'package:equatable/equatable.dart';

abstract class SwipeBarState extends Equatable {
  const SwipeBarState();

  @override
  List<Object> get props => [];
}

class SwipeBarInitial extends SwipeBarState {
  final double offset = .04;

  @override
  List<double> get props => [offset];
}

class SwipeBarMoving extends SwipeBarState {
  final double offset;

  const SwipeBarMoving(this.offset);

  @override
  List<double> get props => [offset];
}

class SwipeBarTop extends SwipeBarState {
  final double offset;

  const SwipeBarTop(this.offset);

  @override
  List<double> get props => [offset];
}
