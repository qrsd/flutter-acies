import 'package:equatable/equatable.dart';

abstract class DiceState extends Equatable {
  const DiceState();

  @override
  List<Object> get props => [];
}

class DiceInitial extends DiceState {
  final int initialRoll = 0;

  @override
  List<Object> get props => [initialRoll];
}

class DiceDoubleRolled extends DiceState {
  final int rollValue;

  DiceDoubleRolled(this.rollValue);

  @override
  List<Object> get props => [rollValue];
}

class DiceRolled extends DiceState {
  final int rollValue;

  DiceRolled(this.rollValue);

  @override
  List<Object> get props => [rollValue];
}
