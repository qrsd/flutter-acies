import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../utils/constants.dart';
import '../history.dart';
import '../route_builder.dart';

/// History widget for calculator screen.
class History extends StatelessWidget {
  /// Parent generates [iconSize].
  final double iconSize;

  /// Constructor
  History(this.iconSize);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<HistoryBloc>(context).add(HistoryShowEvent());
        Navigator.of(context)
            .push(sizedRouteBuilder(
                context, HistoryList(), .4, .6, secondaryColor))
            .then((_) => BlocProvider.of<SwipeBarBloc>(context)
                .add(SwipeBarResetEvent()));
      },
      child: Hero(
        tag: 'history',
        child: Image(
          image: AssetImage('assets/scroll/base.png'),
          width: iconSize,
        ),
      ),
    );
  }
}

/// Bloc builder for the list of all history events.
class HistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
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
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: Hero(
                tag: 'history',
                child: Image(
                  image: AssetImage('assets/scroll/$_page.png'),
                  width: MediaQuery.of(context).size.width / 12,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: PageView(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: PageController(initialPage: _page),
                  onPageChanged: (page) => BlocProvider.of<HistoryBloc>(context)
                      .add(HistoryPageEvent(page)),
                  children: <Widget>[
                    ListBuilder(events, calculatorHistory),
                    ListBuilder(events, calculatorHistory),
                    ListBuilder(events, calculatorHistory)
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
