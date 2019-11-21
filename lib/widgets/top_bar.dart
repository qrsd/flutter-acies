import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../utils/constants.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        InkWell(
          onTap: () =>
              BlocProvider.of<TopBarBloc>(context).add(TopBarBackEvent()),
          child: const Icon(
            Icons.clear,
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
                builder: (context, state) {
                  BlocProvider.of<CalculatorBloc>(context)
                      .add(CalculatorResetEvent());
                  BlocProvider.of<TimerBloc>(context)
                      .add(TimerResetEvent(true));
                  return Row(
                    children: <Widget>[
                      Icon(
                        2 == (state.props[0])
                            ? Icons.check_circle_outline
                            : Icons.radio_button_unchecked,
                        color: 2 == (state.props[0]) ? SECONDARY_COLOR : null,
                      ),
                      Icon(
                        1 <= (state.props[0])
                            ? Icons.check_circle_outline
                            : Icons.radio_button_unchecked,
                        color: 1 <= (state.props[0]) ? SECONDARY_COLOR : null,
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
                    final String minutesStr = ((state.duration / 60) % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    final String secondsStr = (state.duration % 60)
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
                          .add(TimerResetEvent(false)),
                      child: Text(
                        '$minutesStr:$secondsStr',
                        style: const TextStyle(
                          fontSize: 25,
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
                builder: (context, state) {
                  BlocProvider.of<CalculatorBloc>(context)
                      .add(CalculatorResetEvent());
                  BlocProvider.of<TimerBloc>(context)
                      .add(TimerResetEvent(true));
                  return Row(
                    children: <Widget>[
                      Icon(
                        1 <= (state.props[0])
                            ? Icons.check_circle_outline
                            : Icons.radio_button_unchecked,
                        color: 1 <= (state.props[0]) ? SECONDARY_COLOR : null,
                      ),
                      Icon(
                        2 == (state.props[0])
                            ? Icons.check_circle_outline
                            : Icons.radio_button_unchecked,
                        color: 2 == (state.props[0]) ? SECONDARY_COLOR : null,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () =>
              BlocProvider.of<TopBarBloc>(context).add(TopBarNotesEvent()),
          child: const Icon(
            Icons.create,
          ),
        ),
      ],
    );
  }
}
