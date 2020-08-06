import 'package:bloc/bloc.dart';
import 'package:petixpense/imports.dart';

class ExpenseDelegate extends BlocDelegate{
  @override
  void onEvent(Bloc bloc, Object event) {
    // TODO: implement onEvent
    super.onEvent(bloc, event);
    debugPrint("------------Event>> $event");
  }
@override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(bloc, error, stackTrace);
    debugPrint("------------Error>> $error");

}
  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
    debugPrint("------------Transition>> $transition");

  }
}