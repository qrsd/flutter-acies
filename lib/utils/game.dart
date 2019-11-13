import 'dart:convert';

import './constants.dart';

class Game {
  int id;
  int p1LP;
  int p2LP;
  List<int> score;
  List<String> events;
  String delta;
  String notes;
  String opponent;
  DateTime gameStart;

  Game() {
    this.id = 0;
    this.p1LP = START_LP;
    this.p2LP = START_LP;
    this.score = [0, 0];
    this.events = [];
    this.delta = '0000';
    this.opponent = 'Opp';
    this.gameStart = DateTime.now();
  }
}

//  Map<String, dynamic> toMap() {
//    var data = {
//      'opponent': utf8.encode(opponent),
//      'notes': utf8.encode(notes),
//      'score': utf8.encode(score),
//      'date': epochFromDate(gameStart),
//      'events': events,
//    };
//    return data;
//  }
//
//  int epochFromDate(DateTime dt) => dt.millisecondsSinceEpoch ~/ 1000;
//}
