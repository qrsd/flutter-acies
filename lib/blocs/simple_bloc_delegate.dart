import 'package:bloc/bloc.dart';

/// Bloc delegate used to test by printing events/transitions/errors.
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    //print('$event   ${DateTime.now()}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    //print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(bloc);
    print(error);
    print(stacktrace);
  }
}
