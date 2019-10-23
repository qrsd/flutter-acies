import 'package:flutter/material.dart';
import '../utils/controller.dart';

class Keys {
  final String key;
  final String op;

  Keys(this.key, {this.op});
}

abstract class KeyValues {
  static Keys half0 = Keys('1/2', op: 'hlf0');
  static Keys add0 = Keys('add0', op: 'add0');
  static Keys min0 = Keys('min0', op: 'min0');
  static Keys win0 = Keys('win0', op: 'win0');
  static Keys half1 = Keys('1/2', op: 'hlf1');
  static Keys add1 = Keys('add1', op: 'add1');
  static Keys min1 = Keys('min1', op: 'min1');
  static Keys win1 = Keys('win1', op: 'win1');
  static Keys clear = Keys('C', op: 'clr');

  static Keys nine = Keys('9');
  static Keys eight = Keys('8');
  static Keys seven = Keys('7');
  static Keys six = Keys('6');
  static Keys five = Keys('5');
  static Keys four = Keys('4');
  static Keys three = Keys('3');
  static Keys two = Keys('2');
  static Keys one = Keys('1');
  static Keys zero = Keys('0');
  static Keys doubleZero = Keys('00');
  static Keys tripleZero = Keys('000');
}

class KeyButton extends StatelessWidget {
  final Keys value;

  KeyButton(this.value);

  static dynamic fire(KeyButton kb) => KeyController.fire(kb);

  Widget _buildChild({double buttonSize}) {
    if (value.op == 'add0' ||
        value.op == 'add1' ||
        value.op == 'min0' ||
        value.op == 'min1') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: RaisedButton(
          color: value.op == 'add0' || value.op == 'add1'
              ? Colors.green
              : Colors.red,
          elevation: 2,
          onPressed: () => fire(this),
          child: Icon(
            value.op == 'add0' || value.op == 'add1'
                ? Icons.local_hospital
                : Icons.gavel,
            size: 55,
            color: Colors.white,
          ),
        ),
      );
    } else if (value.op == 'win0' || value.op == 'win1') {
      return InkWell(
        onTap: () => fire(this),
        child: Icon(
          Icons.check,
          size: 50,
          color: Colors.white,
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 2),
        width: buttonSize,
        height: 60,
        child: RaisedButton(
          elevation: 2,
          shape: CircleBorder(),
          color: Colors.grey[850],
          onPressed: () => fire(this),
          child: Text(
            value.key,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double buttonSize = (MediaQuery.of(context).size.width - 18) / 3;
    return _buildChild(buttonSize: buttonSize);
  }
}
