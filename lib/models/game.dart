import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class Game extends Equatable {
  final int id;
  final String playerOne;
  final String playerTwo;
  final int playerOneScore;
  final int playerTwoScore;
  final int date;
  final Map<String, dynamic> notes;
  final Map<int, dynamic> history;

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

  @override
  String toString() =>
      'Game id:$id, playerOne:$playerOne, playerTwo:$playerTwo, p1s:$playerOneScore, p2s:$playerTwoScore, date:$date, notes:$notes,history:$history';

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
}
