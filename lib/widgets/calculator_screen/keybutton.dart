import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';

/// Creates all key button widgets using the key values model.
class KeyButton extends StatelessWidget {
  /// [value] provided by key values model.
  final Keys value;

  /// Constructor
  KeyButton(this.value);

  Widget _buildChild(BuildContext context,
      {double buttonSize, double buttonHeight}) {
    var fontSize = (MediaQuery.of(context).size.width) / 16;
    var winIconSize = (MediaQuery.of(context).size.width) / 3 / 2;
    if (value.key.contains('add') || value.key.contains('min')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          height: (MediaQuery.of(context).size.height) * .3 * .3,
          width: (MediaQuery.of(context).size.width) / 3 * .9,
          child: RaisedButton(
            color: value.key.contains('add') ? Colors.green : Colors.red,
            elevation: 2,
            onPressed: () {
              SystemChrome.restoreSystemUIOverlays();
              BlocProvider.of<CalculatorBloc>(context)
                  .add(CalculatorCalculationEvent(value));
            },
            child: FittedBox(
              fit: BoxFit.cover,
              child: Icon(
                value.key.contains('add') ? Icons.local_hospital : Icons.gavel,
                size: 200,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    } else if (value.key.contains('win')) {
      return InkWell(
        onTap: () {
          SystemChrome.restoreSystemUIOverlays();
          BlocProvider.of<TopBarBloc>(context).add(TopBarScoreEvent(value));
          BlocProvider.of<SwipeBarBloc>(context).add(SwipeBarResetEvent());
        },
        child: Icon(
          Icons.check,
          size: winIconSize,
          color: Colors.white,
        ),
      );
    } else {
      return Container(
        width: buttonSize,
        height: buttonHeight,
        child: FlatButton(
          onPressed: () {
            SystemChrome.restoreSystemUIOverlays();
            value.key.contains('hlf')
                ? BlocProvider.of<CalculatorBloc>(context)
                    .add(CalculatorCalculationEvent(value))
                : value.key == 'C'
                    ? BlocProvider.of<CalculatorBloc>(context)
                        .add(CalculatorClearEvent())
                    : BlocProvider.of<CalculatorBloc>(context)
                        .add(CalculatorIntegerEvent(value));
          },
          child: Text(
            value.key.contains('hlf') ? '1/2' : value.key,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var buttonWidth = (MediaQuery.of(context).size.width) / 3;
    var buttonHeight = (MediaQuery.of(context).size.height * .50) / 5;
    return _buildChild(context,
        buttonSize: buttonWidth, buttonHeight: buttonHeight);
  }
}
