import 'package:clutch/core/api_errors/failures.dart';
import 'package:clutch/core/enums/ui_and_bloc_actions.dart';
import 'package:clutch/core/network/api_state.dart';

ApiFailureState HANDLE_FAILURES(Failure failure) {
  if (failure is ServerFailure) {
    return ApiFailureState(
      action: failure.actions,
      msg: failure.msg ?? 'Unknown error',
    );
  } else if (failure is NoInternetFailure) {
    return ApiFailureState(
      msg: 'No Internet access',
      action: UiAndBlocActions.ShowNoInternet,
    );
  }
  return ApiFailureState(msg: 'Unknown error', action: UiAndBlocActions.ShowError);

}
