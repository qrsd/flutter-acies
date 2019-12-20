import 'package:equatable/equatable.dart';

/// Abstact of calculator state.
abstract class CalculatorState extends Equatable {
  /// Constructor
  const CalculatorState();

  @override
  List<Object> get props => [];
}

/// Initial coin state.
class CalculatorInitial extends CalculatorState {}

/// State yielded when calculator delta needs to be cleared.
class CalculatorClear extends CalculatorState {}

/// State yielded when center/delta is updated.
class CalculatorMiddleUpdate extends CalculatorState {
  /// [delta] is the center value of calculator.
  final String delta;

  /// Constructor
  CalculatorMiddleUpdate(this.delta);

  @override
  List<String> get props => [delta];
}

/// State yielded when player one life points is updated.
class CalculatorP1LPUpdate extends CalculatorState {
  /// [p1LP] is their current life points.
  final int p1LP;

  /// [delta] is the change in their life points.
  final String delta;

  /// [add] whether they are gaining or losing life points.
  final bool add;

  /// Constructor
  CalculatorP1LPUpdate(this.p1LP, this.delta, {this.add});

  @override
  List<Object> get props => [p1LP, delta, add];
}

/// State yielded when player two life points is updated.
class CalculatorP2LPUpdate extends CalculatorState {
  /// [p2LP] is their current life points.
  final int p2LP;

  /// [delta] is the change in their life points.
  final String delta;

  /// [add] whether they are gaining or losing life points.
  final bool add;

  /// Constructor
  CalculatorP2LPUpdate(this.p2LP, this.delta, {this.add});

  @override
  List<Object> get props => [p2LP, delta, add];
}

///// State yielded when
//class CalculawtorResume extends CalculatorState {
//  final int player;
//  final int resumeLP;
//
//  CalculatorResume(this.player, this.resumeLP);
//
//  @override
//  List<Object> get props => [player, resumeLP];
//}
