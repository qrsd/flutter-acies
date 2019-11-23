import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
import '../utils/constants.dart';

class KeyButton extends StatelessWidget {
  final Keys value;

  KeyButton(this.value);

  Widget _buildChild(BuildContext context,
      {double buttonSize, double buttonHeight}) {
    if (value.key == 'add0' ||
        value.key == 'add1' ||
        value.key == 'min0' ||
        value.key == 'min1') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: RaisedButton(
          color: value.key == 'add0' || value.key == 'add1'
              ? Colors.green
              : Colors.red,
          elevation: 2,
          onPressed: () {
            SystemChrome.restoreSystemUIOverlays();
            BlocProvider.of<CalculatorBloc>(context)
                .add(CalculatorCalculationEvent(this.value));
          },
          child: Icon(
            value.key == 'add0' || value.key == 'add1'
                ? Icons.local_hospital
                : Icons.gavel,
            size: 70,
            color: Colors.white,
          ),
        ),
      );
    } else if (value.key == 'win0' || value.key == 'win1') {
      return InkWell(
        onTap: () {
          SystemChrome.restoreSystemUIOverlays();
          BlocProvider.of<TopBarBloc>(context)
              .add(TopBarScoreEvent(this.value));
          BlocProvider.of<SwipeBarBloc>(context).add(SwipeBarResetEvent());
        },
        highlightColor: SECONDARY_COLOR,
        child: Icon(
          Icons.check,
          size: 65,
          color: Colors.white,
        ),
      );
    } else {
      return Container(
        width: buttonSize,
        height: buttonHeight,
        child: FlatButton(
          color: PRIMARY_COLOR,
          onPressed: () {
            SystemChrome.restoreSystemUIOverlays();
            value.key == 'hlf0' || value.key == 'hlf1'
                ? BlocProvider.of<CalculatorBloc>(context)
                    .add(CalculatorCalculationEvent(this.value))
                : value.key == 'C'
                    ? BlocProvider.of<CalculatorBloc>(context)
                        .add(CalculatorClearEvent())
                    : BlocProvider.of<CalculatorBloc>(context)
                        .add(CalculatorIntegerEvent(this.value));
          },
          child: Text(
            value.key == 'hlf0' || value.key == 'hlf1' ? '1/2' : value.key,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double buttonSize = (MediaQuery.of(context).size.width) / 3;
    double buttonHeight = (MediaQuery.of(context).size.height * .506) / 5;
    return _buildChild(context,
        buttonSize: buttonSize, buttonHeight: buttonHeight);
  }
}
