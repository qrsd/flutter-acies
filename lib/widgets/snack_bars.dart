import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../utils/constants.dart';

void _snackBarPopUp(BuildContext context, String title, message) {
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

void _snackBarTimerPopUps(BuildContext context, String message) {
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
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    duration: Duration(seconds: 2),
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    message: message,
  )..show(context);
}

class SnackBars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TopBarBloc, TopBarState>(
          condition: (_, state) {
            return state is TopBarBack || state is TopBarNotes ? true : false;
          },
          listener: (context, state) {
            String title;
            if (state is TopBarNotes) {
              title = 'Notes';
            } else {
              title = 'Back';
            }
            _snackBarPopUp(context, title, WIP_MESSAGE);
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
              _snackBarPopUp(context, 'Timer Instructions', TIMER_INSTRUCTIONS);
            } else if (state is TimerRunning) {
              _snackBarTimerPopUps(context, 'Started');
            } else if (state is TimerPaused) {
              _snackBarTimerPopUps(context, 'Paused');
            } else if (state is TimerReady) {
              _snackBarTimerPopUps(context, 'Reset');
            }
          },
        ),
      ],
      child: const SizedBox(),
    );
  }
}
