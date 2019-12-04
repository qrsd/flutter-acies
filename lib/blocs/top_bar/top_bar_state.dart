import 'package:equatable/equatable.dart';

abstract class TopBarState extends Equatable {
  const TopBarState();

  @override
  List<Object> get props => [];
}

class TopBarInitial extends TopBarState {
  final int score = 0;

  @override
  List<int> get props => [score];
}

class TopBarBack extends TopBarState {}

class TopBarMatchOver extends TopBarState {}

class TopBarP1Win extends TopBarState {
  final int score;

  TopBarP1Win(this.score);

  @override
  List<int> get props => [score];
}

class TopBarP2Win extends TopBarState {
  final int score;

  TopBarP2Win(this.score);

  @override
  List<int> get props => [score];
}
