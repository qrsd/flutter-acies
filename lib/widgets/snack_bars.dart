import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../utils/constants.dart';

void noTitleSnackBar(BuildContext context, String message) {
  Flushbar(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.all(10.0),
    borderRadius: 8,
    backgroundColor: SECONDARY_COLOR,
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    overlayBlur: .1,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    duration: Duration(seconds: 1),
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    message: message,
  )..show(context);
}

void resetSnackBar(BuildContext context, String message) {
  Flushbar fb;
  fb = Flushbar(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.all(10.0),
    borderRadius: 8,
    backgroundColor: SECONDARY_COLOR,
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    isDismissible: true,
    overlayBlur: .1,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    duration: Duration(seconds: 5),
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    message: message,
    mainButton: FlatButton(
      onPressed: () {
        fb.dismiss();
        BlocProvider.of<TopBarBloc>(context).add(TopBarResetEvent());
        BlocProvider.of<CalculatorBloc>(context).add(CalculatorResetEvent());
        BlocProvider.of<TimerBloc>(context).add(TimerResetEvent(true));
        BlocProvider.of<HistoryBloc>(context).add(HistoryResetEvent());
        noTitleSnackBar(context, 'Match reset');
      },
      child: const Image(
        image: AssetImage('assets/reset.png'),
        width: 30,
      ),
    ),
  )..show(context);
}

void titleSnackBar(BuildContext context, String title, message) {
  Flushbar(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.all(10.0),
    borderRadius: 8,
    backgroundColor: SECONDARY_COLOR,
    overlayBlur: .7,
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: title,
    messageText: message,
  )..show(context);
}

class SnackBars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TopBarBloc, TopBarState>(
          condition: (_, state) {
            return state is TopBarBack ||
                    state is TopBarNotes ||
                    state is TopBarMatchOver
                ? true
                : false;
          },
          listener: (context, state) {
            String title;
            if (state is TopBarMatchOver) {
              resetSnackBar(context, 'Match over');
            } else {
              if (state is TopBarNotes) {
                title = 'Notes';
              } else {
                title = 'Back';
              }
              titleSnackBar(context, title, WIP_MESSAGE);
            }
          },
        ),
        BlocListener<TimerBloc, TimerState>(
          condition: (previousState, state) {
            if (previousState is TimerRunning && state is TimerRunning) {
              return false;
            } else {
              return true;
            }
          },
          listener: (context, state) {
            if (state is TimerSnack) {
              titleSnackBar(context, 'Timer Instructions', TIMER_INSTRUCTIONS);
            } else if (state is TimerRunning) {
              noTitleSnackBar(context, 'Started');
            } else if (state is TimerPaused) {
              noTitleSnackBar(context, 'Paused');
            } else if (state is TimerReady && !state.matchReset) {
              noTitleSnackBar(context, 'Reset');
            }
          },
        ),
      ],
      child: const SizedBox(),
    );
  }
}
