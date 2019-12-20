import 'package:equatable/equatable.dart';

/// Abstract of top bar state.
abstract class TopBarState extends Equatable {
  /// constructor
  const TopBarState();

  @override
  List<Object> get props => [];
}

/// Initial top bar state.
class TopBarInitial extends TopBarState {
  /// [score] initial.
  final int score = 0;

  @override
  List<int> get props => [score];
}

/// State yielded match is over.
class TopBarMatchOver extends TopBarState {}

/// State yielded player one wins a game, outputs their score.
class TopBarP1Win extends TopBarState {
  /// [score] of player one.
  final int score;

  /// Constructor
  TopBarP1Win(this.score);

  @override
  List<int> get props => [score];
}

/// State yielded when player one wins a game, outputs their score.
class TopBarP2Win extends TopBarState {
  /// [score] of player two.
  final int score;

  /// Constructor
  TopBarP2Win(this.score);

  @override
  List<int> get props => [score];
}
