import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

/// Game models used by BLoCs.
class Game extends Equatable {
  /// [id] of this game.
  final String id;

  /// [playerOne] name of this game.
  final String playerOne;

  /// [playerTwo] name of this game.
  final String playerTwo;

  /// [playerOneScore] of this game.
  final int playerOneScore;

  /// [playerTwoScore] of this game.
  final int playerTwoScore;

  /// [date] of this game.
  final int date;

  /// [notes] contains title/notes of this game.
  final Map<String, dynamic> notes;

  /// [history] contains all events of this game.
  final Map<int, dynamic> history;

  /// Constructor
  const Game(
      {this.id,
      this.playerOne,
      this.playerTwo,
      this.playerOneScore,
      this.playerTwoScore,
      this.date,
      this.notes,
      this.history});

  @override
  List<Object> get props => [
        id,
        playerOne,
        playerTwo,
        playerOneScore,
        playerTwoScore,
        date,
        notes,
        history
      ];

  /// Converts this game model to a game entity.
  GameEntity toEntity() {
    return GameEntity(
      id: id,
      playerOne: playerOne,
      playerTwo: playerTwo,
      playerOneScore: playerOneScore,
      playerTwoScore: playerTwoScore,
      date: date,
      notes: notes,
      history: history,
    );
  }

  /// Creates a game model from a game entity.
  static Game fromEntity(GameEntity entity) {
    return Game(
      id: entity.id,
      playerOne: entity.playerOne,
      playerTwo: entity.playerTwo,
      playerOneScore: entity.playerOneScore,
      playerTwoScore: entity.playerTwoScore,
      date: entity.date,
      notes: entity.notes,
      history: entity.history,
    );
  }

  @override
  String toString() =>
      'Game id:$id, playerOne:$playerOne, playerTwo:$playerTwo, p1s:$playerOneScore, p2s:$playerTwoScore, date:$date, notes:$notes,history:$history';
}
