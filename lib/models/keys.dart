import 'package:equatable/equatable.dart';

class Keys extends Equatable {
  final String key;

  Keys(this.key);

  @override
  List<Object> get props => [key];
}
