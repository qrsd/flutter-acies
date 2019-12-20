import 'package:equatable/equatable.dart';
import '../../utils/constants.dart';

/// Abstract of swipe bar state.
abstract class SwipeBarState extends Equatable {
  /// Constructor
  const SwipeBarState();

  @override
  List<Object> get props => [];
}

/// Initial swipe bar state
class SwipeBarInitial extends SwipeBarState {
  /// [offset] used initially.
  final double offset = swipeBarStart;

  @override
  List<double> get props => [offset];
}

/// State yielded while the swipe bar is moving.
class SwipeBarMoving extends SwipeBarState {
  /// [offset] of movement.
  final double offset;

  /// Constructor
  const SwipeBarMoving(this.offset);

  @override
  List<double> get props => [offset];
}
