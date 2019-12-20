import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/help/widgets.dart';

/// Help screen includes tips on how to use the app.
class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var headerStyle = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: MediaQuery.of(context).size.width / 18);
    var titleStyle = TextStyle(
        fontWeight: FontWeight.bold,
        color: primaryColor,
        fontSize: MediaQuery.of(context).size.width / 20);
    var textStyle = TextStyle(fontSize: MediaQuery.of(context).size.width / 24);
    return Scaffold(
      body: SingleChildScrollView(
        child: Theme(
          data: themeData.copyWith(
              textTheme: TextTheme(subhead: TextStyle(color: secondaryColor)),
              unselectedWidgetColor: secondaryColor,
              accentColor: primaryColor,
              dividerColor: primaryColor),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TopBar(),
              ),
              ExpansionTile(
                backgroundColor: secondaryColor,
                title: Text(
                  'calculator',
                  style: headerStyle,
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text('life points', style: titleStyle),
                        ),
                        Text(
                          'Tapping a keypad button updates the center, unless it\'s the 1/2 button which halves the life points of the player in the same column. To add or subtract life points tap the buttons under the player\'s life points.',
                          style: textStyle,
                        ),
                        const SizedBox(height: 15.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text('player names', style: titleStyle),
                        ),
                        Text(
                          'Player names can be changed by tapping on them and setting a new one. The character limit on a name is 8. Changes to a player\'s name will also be reflected in the match list and history.',
                          style: textStyle,
                        ),
                        const SizedBox(height: 15.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text('wins', style: titleStyle),
                        ),
                        Text(
                          'To indicate a player has won a game tap the appropriate check mark. A match ends when one player has achieved two wins.',
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                backgroundColor: secondaryColor,
                title: Text(
                  'match history',
                  style: headerStyle,
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'All games are recorded and displayed in the match history page.',
                            style: textStyle,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text('player names', style: titleStyle),
                        ),
                        Text(
                          'Player names can be changed on the calculator page and will be reflected on the saved game.',
                          style: textStyle,
                        ),
                        const SizedBox(height: 15.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'title',
                            style: titleStyle,
                          ),
                        ),
                        Text(
                          'The title reflects the title set in notes. If there is no title it will just display the date of when the game ended.',
                          style: textStyle,
                        ),
                        const SizedBox(height: 15.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'history/notes',
                            style: titleStyle,
                          ),
                        ),
                        Text(
                          'The history icon will display all events from the match. You can swipe through all games. The notes icon will display all notes taken during the match.',
                          style: textStyle,
                        ),
                        const SizedBox(height: 15.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'delete',
                            style: titleStyle,
                          ),
                        ),
                        Text(
                          'You can delete matches by swiping them away.',
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                backgroundColor: secondaryColor,
                title: Text(
                  'notes',
                  style: headerStyle,
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'The notes feature is the pencil icon located at the top right of the calculator page. Notes are saved when a match ends and you hit reset. They can be viewed later in the match history page with the same title set in notes.',
                          style: textStyle,
                        ),
                        const SizedBox(height: 15.0),
                      ],
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                backgroundColor: secondaryColor,
                title: Text(
                  'swipe up bar',
                  style: headerStyle,
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'You can tap on the bar or swipe it up to see it\'s features.',
                            style: textStyle,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'coin/die',
                            style: titleStyle,
                          ),
                        ),
                        Text(
                          'Tapping on either the coin or die opens a page displaying them. Tapping on them will shake a result. To exit tap outside of it.',
                          style: textStyle,
                        ),
                        const SizedBox(height: 15.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'history',
                            style: titleStyle,
                          ),
                        ),
                        Text(
                          'Tapping on history will bring up a page with every event that\'s happened this match. You can also swipe through the previous games. To exit tap outside of it.',
                          style: textStyle,
                        ),
                        const SizedBox(height: 15.0),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            'reset',
                            style: titleStyle,
                          ),
                        ),
                        Text(
                          'Tapping this resets the current match. Notes, history, wins, and life points are all reset.',
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                backgroundColor: secondaryColor,
                title: Text(
                  'timer',
                  style: headerStyle,
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'All functions are used on the timer itself.',
                          style: textStyle,
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Tap',
                                  style: textStyle,
                                ),
                                Text(
                                  'Double Tap',
                                  style: textStyle,
                                ),
                                Text(
                                  'Long Press',
                                  style: textStyle,
                                ),
                                Text(
                                  'Drag',
                                  style: textStyle,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Display Instructions',
                                  style: textStyle,
                                ),
                                Text(
                                  'Start Timer',
                                  style: textStyle,
                                ),
                                Text(
                                  'Pause Timer',
                                  style: textStyle,
                                ),
                                Text(
                                  'Reset Timer',
                                  style: textStyle,
                                ),
                              ],
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
