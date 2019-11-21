import 'package:equatable/equatable.dart';

abstract class DiceEvent extends Equatable {
  const DiceEvent();

  @override
  List<Object> get props => [];
}

class DiceResetEvent extends DiceEvent {}

class DiceRollEvent extends DiceEvent {}
