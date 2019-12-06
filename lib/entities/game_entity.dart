import 'dart:convert';
import 'package:equatable/equatable.dart';

class GameEntity extends Equatable {
  final int id;
  final String playerOne;
  final String playerTwo;
  final int playerOneScore;
  final int playerTwoScore;
  final int date;
  final Map<String, dynamic> notes;
  final Map<int, dynamic> history;

  const GameEntity(
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

  Map<String, Object> toJson() {
    return {
      'id': id,
      'playerOne': playerOne,
      'playerTwo': playerTwo,
      'playerOneScore': playerOneScore,
      'playerTwoScore': playerTwoScore,
      'date': date,
      'notes': jsonEncode(notes),
      'history': jsonEncode(history.map((a, b) => MapEntry(a.toString(), b))),
    };
  }

  static GameEntity fromJson(Map<String, Object> json) {
    return GameEntity(
      id: json['id'] as int,
      playerOne: json['playerOne'] as String,
      playerTwo: json['playerTwo'] as String,
      playerOneScore: json['playerOneScore'] as int,
      playerTwoScore: json['playerTwoScore'] as int,
      date: json['date'] as int,
      notes: jsonDecode(json['notes']),
      history: Map<int, dynamic>.from(
          jsonDecode(json['history']).map((a, b) => MapEntry(int.parse(a), b))),
    );
  }

  @override
  String toString() =>
      'GameEntity id:$id, playerOne:$playerOne, playerTwo:$playerTwo, p1s:$playerOneScore, p2s:$playerTwoScore, date:$date, notes:$notes,history:$history';
}
