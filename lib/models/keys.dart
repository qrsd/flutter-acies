import 'package:equatable/equatable.dart';

/// Model representation of each key used by key buttons.
class Keys extends Equatable {
  /// [key] stores the representation of each button.
  final String key;

  /// Constructor
  Keys(this.key);

  @override
  List<Object> get props => [key];
}

// ignore_for_file: public_member_api_docs
final Keys half0 = Keys('hlf0');
final Keys add0 = Keys('add0');
final Keys min0 = Keys('min0');
final Keys win0 = Keys('win0');
final Keys half1 = Keys('hlf1');
final Keys add1 = Keys('add1');
final Keys min1 = Keys('min1');
final Keys win1 = Keys('win1');
final Keys clear = Keys('C');

final Keys nine = Keys('9');
final Keys eight = Keys('8');
final Keys seven = Keys('7');
final Keys six = Keys('6');
final Keys five = Keys('5');
final Keys four = Keys('4');
final Keys three = Keys('3');
final Keys two = Keys('2');
final Keys one = Keys('1');
final Keys zero = Keys('0');
final Keys doubleZero = Keys('00');
final Keys tripleZero = Keys('000');
