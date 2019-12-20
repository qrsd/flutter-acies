import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flushbar/flushbar.dart';

import '../blocs/blocs.dart';
import '../utils/constants.dart';
import '../widgets/calculator_screen/reset.dart';

/// Create a snackbar with no title.
void noTitleSnackBar(BuildContext context, String message) {
  var textStyle = TextStyle(fontSize: MediaQuery.of(context).size.width / 28);
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
    messageText: Text(
      message,
      style: textStyle,
    ),
  )..show(context);
}

/// Create a snackbar with widget and optional function.
void widgetSnackBar(BuildContext context, String message, Widget widget,
    {Function function}) {
  Flushbar fb;
  var textStyle = TextStyle(fontSize: MediaQuery.of(context).size.width / 26);
  fb = Flushbar(
    padding: const EdgeInsets.all(20.0),
    margin: const EdgeInsets.all(10.0),
    borderRadius: 8,
    backgroundColor: message == 'Game Deleted' ? primaryColor : secondaryColor,
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
      style: textStyle,
    ),
    mainButton: FlatButton(
      onPressed: () {
        fb.dismiss();
        function();
      },
      child: widget,
    ),
  )..show(context);
}

/// Create a snackbar with a title.
void titleSnackBar(BuildContext context, String title, String identifier) {
  var message;
  var messageStyle =
      TextStyle(fontSize: MediaQuery.of(context).size.width / 29);
  var titleStyle = TextStyle(
    fontSize: MediaQuery.of(context).size.width / 22,
    fontWeight: FontWeight.bold,
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
    titleText: Text(
      title,
      style: titleStyle,
    ),
    messageText: message,
  )..show(context);
}

/// Listens for state changes and renders appropriate snackbar based on state.
class SnackBars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<TopBarBloc, TopBarState>(
          condition: (_, state) {
            return state is TopBarMatchOver ? true : false;
          },
          listener: (context, state) {
            if (state is TopBarMatchOver) {
              widgetSnackBar(
                context,
                'Match over',
                Image(
                  image: AssetImage('assets/reset.png'),
                  width: MediaQuery.of(context).size.width / 12,
                ),
                function: () => onTapReset(context),
              );
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
