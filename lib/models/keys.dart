import 'package:equatable/equatable.dart';

class Keys extends Equatable {
  final String key;
  final bool operation;

  Keys(this.key, {this.operation = false});

  @override
  List<Object> get props => [
        key,
        {operation},
      ];
}
