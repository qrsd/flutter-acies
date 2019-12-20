import 'dart:convert';
import 'package:equatable/equatable.dart';

/// Game entities used when loading/saving to file storage.
class GameEntity extends Equatable {
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

  /// Converts this entity to Json.
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

  /// Converts Json entry to entity.
  static GameEntity fromJson(Map<String, Object> json) {
    return GameEntity(
      id: json['id'] as String,
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
