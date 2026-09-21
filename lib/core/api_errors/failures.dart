import 'package:clutch/core/enums/ui_and_bloc_actions.dart';

sealed class Failure {}

class NoInternetFailure extends Failure {}

class ServerFailure extends Failure {
  final UiAndBlocActions actions; 
  final String? msg;

  new({required this.actions,  this.msg}); 
}

