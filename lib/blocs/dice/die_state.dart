import 'package:equatable/equatable.dart';

/// Abstract of die state.
abstract class DieState extends Equatable {
  /// Constructor
  const DieState();

  @override
  List<Object> get props => [];
}

/// Initial die state.
class DieInitial extends DieState {
  /// [initialRoll] of die.
  final int initialRoll = 0;

  @override
  List<Object> get props => [initialRoll];
}

/// State yielded if die rolled a double.
class DieDoubleRolled extends DieState {
  /// [rollValue] of die.
  final int rollValue;

  /// Constructor
  DieDoubleRolled(this.rollValue);

  @override
  List<Object> get props => [rollValue];
}

/// State yielded when die is rolled.
class DieRolled extends DieState {
  /// [rollValue] of die.
  final int rollValue;

  /// Constructor
  DieRolled(this.rollValue);

  @override
  List<Object> get props => [rollValue];
}
