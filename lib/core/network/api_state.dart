import 'package:clutch/core/enums/ui_and_bloc_actions.dart';
import 'package:equatable/equatable.dart';

sealed class ApiState<SuccessCaseDataType> extends Equatable {}

class ApiInitState extends ApiState {
  @override
  List<Object?> get props => [];
}

class ApiLoadingState extends ApiState {
  @override
  List<Object?> get props => [];
}

class ApiSuccessState<SuccessCaseDataType>
    extends ApiState<SuccessCaseDataType> {
  final SuccessCaseDataType data;

  ApiSuccessState({required this.data});

  @override
  List<Object?> get props => [];
}

class ApiFailureState<SuccessCaseDataType>
    extends ApiState<SuccessCaseDataType> {
  final String msg;
  final UiAndBlocActions action;
  ApiFailureState({required this.msg, required this.action});

  @override
  List<Object?> get props => [];
}
