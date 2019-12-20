import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../screens/screens.dart';
import '../../utils/constants.dart';
import '../route_builder.dart';
import './widgets.dart';

/// Top Bar widget for calculator screen.
class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var iconSize = MediaQuery.of(context).size.width / 13;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          onTap: () => Navigator.of(context).push(fullRouteBuilder(
              context, GamesListScreen(), Offset(1.0, 0.0), Offset.zero)),
          child: Icon(
            Icons.arrow_back_ios,
            size: iconSize,
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              BlocBuilder<TopBarBloc, TopBarState>(
                condition: (_, state) {
                  return state is TopBarP1Win || state is TopBarInitial
                      ? true
                      : false;
                },
                builder: (_, state) {
                  return Row(
                    children: <Widget>[
                      Icon(
                        2 == (state.props[0])
                            ? Icons.check_circle_outline
                            : Icons.radio_button_unchecked,
                        color: 2 == (state.props[0]) ? secondaryColor : null,
                        size: iconSize,
                      ),
                      Icon(
                        1 <= (state.props[0])
                            ? Icons.check_circle_outline
                            : Icons.radio_button_unchecked,
                        color: 1 <= (state.props[0]) ? secondaryColor : null,
                        size: iconSize,
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: BlocBuilder<TimerBloc, TimerState>(
                  condition: (_, state) {
                    return state is TimerSnack ? false : true;
                  },
                  builder: (context, state) {
                    final minutesStr = ((state.duration / 60) % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    final secondsStr = (state.duration % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    return GestureDetector(
                      onTap: () => BlocProvider.of<TimerBloc>(context)
                          .add(TimerSnackBarEvent()),
                      onDoubleTap: () => BlocProvider.of<TimerBloc>(context)
                          .add(TimerStartEvent(state.duration)),
                      onLongPress: () => BlocProvider.of<TimerBloc>(context)
                          .add(TimerPauseEvent()),
                      onPanUpdate: (_) => BlocProvider.of<TimerBloc>(context)
                          .add(TimerResetEvent(matchReset: false)),
                      child: Text(
                        '$minutesStr:$secondsStr',
                        style: TextStyle(
                          fontSize: (MediaQuery.of(context).size.width) / 14,
                        ),
                      ),
                    );
                  },
                ),
              ),
              BlocBuilder<TopBarBloc, TopBarState>(
                condition: (_, state) {
                  return state is TopBarP2Win || state is TopBarInitial
                      ? true
                      : false;
                },
                builder: (_, state) {
                  return Row(
                    children: <Widget>[
                      Icon(
                        1 <= (state.props[0])
                            ? Icons.check_circle_outline
                            : Icons.radio_button_unchecked,
                        color: 1 <= (state.props[0]) ? secondaryColor : null,
                        size: iconSize,
                      ),
                      Icon(
                        2 == (state.props[0])
                            ? Icons.check_circle_outline
                            : Icons.radio_button_unchecked,
                        color: 2 == (state.props[0]) ? secondaryColor : null,
                        size: iconSize,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        Notes(iconSize),
      ],
    );
  }
}
