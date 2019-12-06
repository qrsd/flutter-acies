import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../utils/constants.dart';

void noTitleSnackBar(context, String message) {
  Text messageToText = Text(
    message,
    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 28),
  );
  Flushbar(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.all(10.0),
    borderRadius: 8,
    backgroundColor: secondaryColor,
    boxShadows: [
      const BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    overlayBlur: .1,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    duration: Duration(seconds: 1),
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    messageText: messageToText,
  )..show(context);
}

void resetSnackBar(context, String message) {
  Flushbar fb;
  TextStyle messageStyle =
      TextStyle(fontSize: MediaQuery.of(context).size.width / 26);
  fb = Flushbar(
    padding: const EdgeInsets.all(20.0),
    margin: const EdgeInsets.all(10.0),
    borderRadius: 8,
    backgroundColor: secondaryColor,
    boxShadows: [
      const BoxShadow(
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
    messageText: Text(
      message,
      style: messageStyle,
    ),
    mainButton: FlatButton(
      onPressed: () {
        fb.dismiss();
        BlocProvider.of<TopBarBloc>(context).add(TopBarResetEvent());
        BlocProvider.of<CalculatorBloc>(context).add(CalculatorResetEvent());
        BlocProvider.of<TimerBloc>(context).add(TimerResetEvent(true));
        BlocProvider.of<HistoryBloc>(context).add(HistoryResetEvent());
        BlocProvider.of<NotesBloc>(context).add(NotesResetEvent());
        noTitleSnackBar(context, 'Match reset');
      },
      child: Image(
        image: AssetImage('assets/reset.png'),
        width: MediaQuery.of(context).size.width / 12,
      ),
    ),
  )..show(context);
}

void titleSnackBar(context, title, identifier) {
  var message;
  var titleText;
  TextStyle messageStyle =
      TextStyle(fontSize: MediaQuery.of(context).size.width / 29);
  TextStyle titleStyle = TextStyle(
    fontSize: MediaQuery.of(context).size.width / 22,
    fontWeight: FontWeight.bold,
  );
  titleText = Text(
    title,
    style: titleStyle,
  );
  if (identifier == 'wip') {
    message = Text(
      'This feature is a W.I.P. and is not currently implemented',
      style: messageStyle,
    );
  } else if (identifier == 'timer') {
    message = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Tap',
              style: messageStyle,
            ),
            Text(
              'Double Tap',
              style: messageStyle,
            ),
            Text(
              'Long Press',
              style: messageStyle,
            ),
            Text(
              'Drag',
              style: messageStyle,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Display Instructions',
              style: messageStyle,
            ),
            Text(
              'Start Timer',
              style: messageStyle,
            ),
            Text(
              'Pause Timer',
              style: messageStyle,
            ),
            Text(
              'Reset Timer',
              style: messageStyle,
            ),
          ],
        ),
        const SizedBox(),
      ],
    );
  }
  Flushbar(
    padding: const EdgeInsets.all(10.0),
    margin: const EdgeInsets.all(10.0),
    borderRadius: 8,
    backgroundColor: secondaryColor,
    overlayBlur: .7,
    boxShadows: [
      const BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    titleText: titleText,
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
            return state is TopBarBack || state is TopBarMatchOver
                ? true
                : false;
          },
          listener: (context, state) {
            if (state is TopBarMatchOver) {
              resetSnackBar(context, 'Match over');
            } else if (state is TopBarBack) {
              titleSnackBar(context, 'Back', 'wip');
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
              titleSnackBar(context, 'Timer Instructions', 'timer');
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
