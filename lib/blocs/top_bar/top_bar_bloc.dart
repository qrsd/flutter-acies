import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:lp_calc/blocs/blocs.dart';
import './bloc.dart';

class TopBarBloc extends Bloc<TopBarEvent, TopBarState> {
  final CalculatorBloc calculatorBloc;
  StreamSubscription calculatorSubscription;

  TopBarBloc({@required this.calculatorBloc}) {
    calculatorSubscription = calculatorBloc.listen((state) {
      if (state is GameWin) {
        add(ScoreUpdate((calculatorBloc.state as GameWin).player));
      }
    });
  }

  @override
  TopBarState get initialState => TopBarInitial();

  @override
  Stream<TopBarState> mapEventToState(
    TopBarEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
