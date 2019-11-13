import '../models/models.dart';

abstract class KeyValues {
  static final Keys half0 = Keys('hlf0', operation: true);
  static final Keys add0 = Keys('add0', operation: true);
  static final Keys min0 = Keys('min0', operation: true);
  static final Keys win0 = Keys('win0', operation: true);
  static final Keys half1 = Keys('hlf1', operation: true);
  static final Keys add1 = Keys('add1', operation: true);
  static final Keys min1 = Keys('min1', operation: true);
  static final Keys win1 = Keys('win1', operation: true);
  static final Keys clear = Keys('C', operation: true);

  static final Keys nine = Keys('9');
  static final Keys eight = Keys('8');
  static final Keys seven = Keys('7');
  static final Keys six = Keys('6');
  static final Keys five = Keys('5');
  static final Keys four = Keys('4');
  static final Keys three = Keys('3');
  static final Keys two = Keys('2');
  static final Keys one = Keys('1');
  static final Keys zero = Keys('0');
  static final Keys doubleZero = Keys('00');
  static final Keys tripleZero = Keys('000');
}
