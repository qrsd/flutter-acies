import 'package:acies/models/models.dart';
import 'package:equatable/equatable.dart';

abstract class GamesEvent extends Equatable {
  const GamesEvent();

  @override
  List<Object> get props => [];
}

class GamesDeleteEvent extends GamesEvent {
  final Game game;

  GamesDeleteEvent(this.game);

  @override
  List<Object> get props => [game];
}

class GamesHistoryEvent extends GamesEvent {
  final String playerOne;
  final String playerTwo;
  final int playerOneScore;
  final int playerTwoScore;
  final Map<int, dynamic> history;

  GamesHistoryEvent(this.playerOne, this.playerTwo, this.playerOneScore,
      this.playerTwoScore, this.history);

  @override
  List<Object> get props =>
      [playerOne, playerTwo, playerOneScore, playerTwoScore, history];
}

class GamesLoadEvent extends GamesEvent {}

class GamesNotesEvent extends GamesEvent {
  final Map<String, dynamic> notes;

  GamesNotesEvent(this.notes);

  @override
  List<Object> get props => [notes];
}
