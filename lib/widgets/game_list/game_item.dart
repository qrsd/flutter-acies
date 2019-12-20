import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../utils/constants.dart';
import './widgets.dart';

/// Each individual game widget displayed in game_list_screen.
class GameItem extends StatelessWidget {
  /// [game] provides all data to be displayed.
  final Game game;

  /// Displays a snackbar prompting if player would like to undo delete.
  final DismissDirectionCallback onDismissed;

  /// Constructor
  GameItem(this.game, this.onDismissed);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 3.5;
    var iconSize = MediaQuery.of(context).size.width / 13;
    var textStyle = TextStyle(fontSize: MediaQuery.of(context).size.width / 24);
    var date = DateTime.fromMillisecondsSinceEpoch(game.date * 1000).toLocal();
    return Card(
      elevation: 5,
      color: secondaryColor,
      margin: EdgeInsets.all(5.0),
      child: Dismissible(
        key: ValueKey(game.id),
        onDismissed: onDismissed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: width * .8,
                          child: Text(
                            '${game.playerOne}',
                            textAlign: TextAlign.center,
                            style: textStyle.copyWith(
                                color: game.playerOneScore > game.playerTwoScore
                                    ? Colors.green[800]
                                    : Colors.red[900]),
                          ),
                        ),
                        Container(
                          width: width * .8,
                          child: Text(
                            '${game.playerTwo}',
                            textAlign: TextAlign.center,
                            style: textStyle.copyWith(
                                color: game.playerOneScore < game.playerTwoScore
                                    ? Colors.green[800]
                                    : Colors.red[900]),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '${game.playerOneScore.toString()}',
                          style: textStyle.copyWith(
                              color: game.playerOneScore > game.playerTwoScore
                                  ? Colors.green[800]
                                  : Colors.red[900]),
                        ),
                        Text(
                          '${game.playerTwoScore.toString()}',
                          style: textStyle.copyWith(
                              color: game.playerOneScore < game.playerTwoScore
                                  ? Colors.green[800]
                                  : Colors.red[900]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: width,
                child: game.notes.keys.first == ''
                    ? Text(
                        '${date.month}-${date.day}-${(date.year % 2000)} ${(date.hour - 12).abs()}:${date.minute}',
                        style: textStyle,
                        textAlign: TextAlign.center,
                      )
                    : Column(
                        children: <Widget>[
                          Text(
                            game.notes.keys.first,
                            style: textStyle,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${date.month}-${date.day}-${(date.year % 2000)} ${(date.hour - 12).abs()}:${date.minute}',
                            style: textStyle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
              ),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    History(game.id, iconSize, game.history),
                    Notes(iconSize, game.notes),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
