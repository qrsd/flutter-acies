import 'package:acies/models/models.dart';
import 'package:equatable/equatable.dart';

/// Abstract of games events.
abstract class GamesEvent extends Equatable {
  /// Constructor
  const GamesEvent();

  @override
  List<Object> get props => [];
}

/// Event fires when adding a game to the list of games.
class GamesAddEvent extends GamesEvent {
  /// [game] to be added.
  final Game game;

  /// Constructor
  GamesAddEvent(this.game);

  @override
  List<Object> get props => [game];
}

/// Event fires when a game is to be deleted.
class GamesDeleteEvent extends GamesEvent {
  /// [game] to be deleted.
  final Game game;

  /// Constructor
  GamesDeleteEvent(this.game);

  @override
  List<Object> get props => [game];
}

/// Event fires when collecting all of a game's history.
class GamesHistoryEvent extends GamesEvent {
  /// [playerOne] name.
  final String playerOne;

  /// [playerTwo] name.
  final String playerTwo;

  /// [playerOneScore] of games.
  final int playerOneScore;

  /// [playerTwoScore] of games.
  final int playerTwoScore;

  /// [history] events of games.
  final Map<int, dynamic> history;

  /// Constructor
  GamesHistoryEvent(this.playerOne, this.playerTwo, this.playerOneScore,
      this.playerTwoScore, this.history);

  @override
  List<Object> get props =>
      [playerOne, playerTwo, playerOneScore, playerTwoScore, history];
}

/// Event fires when all games are being loaded.
class GamesLoadEvent extends GamesEvent {}

/// Event fires when collecting the notes of the games.
class GamesNotesEvent extends GamesEvent {
  /// [notes] being collected.
  final Map<String, dynamic> notes;

  /// Constructor
  GamesNotesEvent(this.notes);

  @override
  List<Object> get props => [notes];
}
