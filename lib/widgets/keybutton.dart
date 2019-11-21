import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';
import '../models/models.dart';
import '../utils/constants.dart';

class KeyButton extends StatelessWidget {
  final Keys value;

  KeyButton(this.value);

  Widget _buildChild(BuildContext context, {double buttonSize}) {
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
          onPressed: () => BlocProvider.of<CalculatorBloc>(context)
              .add(CalculatorCalculationEvent(this.value)),
          child: Icon(
            value.key == 'add0' || value.key == 'add1'
                ? Icons.local_hospital
                : Icons.gavel,
            size: 55,
            color: Colors.white,
          ),
        ),
      );
    } else if (value.key == 'win0' || value.key == 'win1') {
      return InkWell(
        onTap: () => BlocProvider.of<TopBarBloc>(context)
            .add(TopBarScoreEvent(this.value)),
        highlightColor: SECONDARY_COLOR,
        child: Icon(
          Icons.check,
          size: 50,
          color: Colors.white,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 2),
        width: buttonSize,
        height: 60,
        child: RaisedButton(
          elevation: 2,
          shape: CircleBorder(),
          color: Colors.grey[850],
          onPressed: () => value.key == 'hlf0' || value.key == 'hlf1'
              ? BlocProvider.of<CalculatorBloc>(context)
                  .add(CalculatorCalculationEvent(this.value))
              : value.key == 'C'
                  ? BlocProvider.of<CalculatorBloc>(context)
                      .add(CalculatorClearEvent())
                  : BlocProvider.of<CalculatorBloc>(context)
                      .add(CalculatorIntegerEvent(this.value)),
          child: Text(
            value.key == 'hlf0' || value.key == 'hlf1' ? '1/2' : value.key,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double buttonSize = (MediaQuery.of(context).size.width - 18) / 3;
    return _buildChild(context, buttonSize: buttonSize);
  }
}
