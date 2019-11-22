import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './widgets.dart';
import '../blocs/blocs.dart';

class ResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<CalculatorBloc>(context).add(CalculatorResetEvent());
        BlocProvider.of<HistoryBloc>(context).add(HistoryResetEvent());
        BlocProvider.of<TimerBloc>(context).add(TimerResetEvent(true));
        BlocProvider.of<TopBarBloc>(context).add(TopBarResetEvent());
        BlocProvider.of<SwipeBarBloc>(context).add(SwipeBarResetEvent());
        noTitleSnackBar(context, 'Match reset');
      },
      child: const Image(image: AssetImage('assets/reset.png'), width: 35),
    );
  }
}
