import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../blocs/blocs.dart';
import '../utils/constants.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _currentGame = 0;
    return BlocListener<HistoryBloc, HistoryState>(
      listener: (context, state) {
        if (state is HistoryWin) {
          _currentGame = state.game > 2 ? 2 : state.game;
          print(_currentGame);
        } else if (state is HistoryInitial) {
          _currentGame = 0;
        }
      },
      child: InkWell(
        onTap: () {
          BlocProvider.of<HistoryBloc>(context)
              .add(HistoryPageEvent(_currentGame));
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,
              barrierDismissible: true,
              pageBuilder: (context, animation, __) {
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: SECONDARY_COLOR
                          .withOpacity(animation.value == 1 ? 1 : 0),
                      boxShadow: animation.value == 1
                          ? [
                              BoxShadow(
                                color: Colors.black45,
                                offset: Offset(3, 3),
                                blurRadius: 10,
                              ),
                            ]
                          : null,
                    ),
                    height: MediaQuery.of(context).size.width * .7,
                    width: MediaQuery.of(context).size.width * .5,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(top: 5),
                    child: BlocBuilder<HistoryBloc, HistoryState>(
                      condition: (_, state) {
                        return state is HistoryPage ? true : false;
                      },
                      builder: (context, state) {
                        final _page = state.props[0];
                        var events;
                        if (state is HistoryPage) {
                          events = state.history;
                        }
                        return Column(
                          children: <Widget>[
                            Hero(
                              tag: 'history',
                              child: Image(
                                image: AssetImage('assets/scroll/$_page.png'),
                                width: 30,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: PreloadPageView(
                                  preloadPagesCount: 3,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  controller: PreloadPageController(
                                      initialPage: _currentGame),
                                  onPageChanged: (page) =>
                                      BlocProvider.of<HistoryBloc>(context)
                                          .add(HistoryPageEvent(page)),
                                  children: <Widget>[
                                    ListBuilder(events),
                                    ListBuilder(events),
                                    ListBuilder(events)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
        child: Hero(
          tag: 'history',
          child: const Image(
            image: AssetImage('assets/scroll/base.png'),
            width: 30,
          ),
        ),
      ),
    );
  }
}

class ListBuilder extends StatelessWidget {
  final events;

  ListBuilder(this.events);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        addRepaintBoundaries: false,
        itemCount: events?.length ?? 0,
        itemBuilder: (context, i) {
          final event = events[i];
          return EventItem(event);
        },
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final event;

  EventItem(this.event);

  @override
  Widget build(BuildContext context) {
    if (event == null) {
      return Text('');
    } else {
      final splitEvent = event.split(' ');
      double size;
      double space;
      Color textColor = Colors.white;
      if (splitEvent[1][0] == '+') {
        size = 16;
        textColor = Colors.green[800];
      } else if (splitEvent[1][0] == '-') {
        space = 4;
        textColor = Colors.red[900];
      } else if (splitEvent[1].contains('Won')) {
        textColor = PRIMARY_COLOR;
      }
      return Material(
        color: SECONDARY_COLOR,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Text(
                  splitEvent[0],
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: splitEvent[1][0],
                        style: TextStyle(
                          textBaseline: TextBaseline.ideographic,
                          fontSize: size ?? 18,
                          letterSpacing: space ?? null,
                        ),
                      ),
                      TextSpan(
                        text: splitEvent[1].substring(1),
                      ),
                    ],
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
