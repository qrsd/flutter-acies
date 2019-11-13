import 'package:equatable/equatable.dart';

abstract class TopBarState extends Equatable {
  const TopBarState();
}

class TopBarInitial extends TopBarState {
  final int score = 0;

  @override
  List<int> get props => [score];
}

class P1Win extends TopBarState {
  final int score;

  P1Win(this.score);

  @override
  List<int> get props => [score];
}

class P2Win extends TopBarState {
  final int score;

  P2Win(this.score);

  @override
  List<int> get props => [score];
}
