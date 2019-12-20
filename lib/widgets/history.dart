import 'package:flutter/material.dart';

import '../utils/constants.dart';

/// These widgets are shared between calculator screen and game list screen
/// in regards to their history widget.

/// Builds a list view of all events in History List.
class ListBuilder extends StatelessWidget {
  /// [events] is a list of events extracted from the history map.
  final List<dynamic> events;

  /// [type] of parent
  final int type;

  /// Constructor
  ListBuilder(this.events, this.type);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        addRepaintBoundaries: false,
        itemCount: events?.length ?? 0,
        itemBuilder: (context, i) {
          final event = events[i];
          return EventItem(event, type);
        },
      ),
    );
  }
}

/// Different events have different styling, this separates events and assigns styling .
class EventItem extends StatelessWidget {
  /// [event] individual event.
  final String event;

  /// [type] of parent
  final int type;

  /// Constructor
  EventItem(this.event, this.type);

  @override
  Widget build(BuildContext context) {
    var fontSize = MediaQuery.of(context).size.width / 22;
    if (event == null) {
      return Text('');
    } else {
      final splitEvent = event.split(' ');
      var textColor = Colors.white;
      if (splitEvent[1][0] == '+') {
        textColor = Colors.green[800];
      } else if (splitEvent[1][0] == '-') {
        textColor = Colors.red[900];
      } else if (splitEvent[1].contains('Won')) {
        textColor = type == calculatorHistory ? primaryColor : secondaryColor;
      }
      return Material(
        color: type == calculatorHistory ? secondaryColor : primaryColor,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  splitEvent[0],
                  style: TextStyle(
                    fontSize: fontSize,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  splitEvent[1],
                  style: TextStyle(
                    fontSize: fontSize,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
