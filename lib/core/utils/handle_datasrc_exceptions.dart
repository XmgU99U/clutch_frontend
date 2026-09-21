import 'package:clutch/core/api_errors/exceptions.dart';
import 'package:clutch/core/api_errors/failures.dart';
import 'package:clutch/core/datasrc/local/token_local_datasrc.dart';
import 'package:clutch/core/datasrc/remote/token_remote_datasrc.dart';
import 'package:clutch/core/enums/ui_and_bloc_actions.dart';

Future<Failure> HANDLE_DATASRC_EXCEPTIONS(Object e) async {
  if (e is InvalidInputException) {
    return ServerFailure(
      actions: UiAndBlocActions.ShowError,
      msg: e.msg ,
    );
  }
  if (e is InvaliCredentialsException) {
    return ServerFailure(
      actions: UiAndBlocActions.ShowError,
      msg: e.msg ,
    );
  }
  if (e is RateLimitedException) {
    return ServerFailure(
      actions: UiAndBlocActions.ShowError,
      msg: 'Too many requests',
    );
  }
  if (e is InvalidTokenException) {
    return ServerFailure(actions: UiAndBlocActions.LeaveTheProtectedPages);
  }
  if (e is ExpiredTokenException) {
    try {
      final String refreshToken =
           TokenLocalDatasrc().getRefreshToken as String;
      final accessToken = await TokenRemoteDatasrc().refresh(
        refreshToken: refreshToken,
      );
      TokenLocalDatasrc().storeAccessToken(
         accessToken,
      ); // this might throw exception if token is expired or Invalid ....
      

      return ServerFailure(actions: UiAndBlocActions.ReCallMethod);
    } catch (_) {
      return ServerFailure(actions: UiAndBlocActions.LeaveTheProtectedPages);
    }
  }
  if (e is NotAuthorizedException) {
    return ServerFailure(
      actions: UiAndBlocActions.ShowError,
      msg: e.msg ,
    );
  }
  if (e is NotFoundException) {
    return ServerFailure(
      actions: UiAndBlocActions.ShowError,
      msg: e.msg ,
    );
  }
  if (e is UnverifiedUserException) {
    return ServerFailure(actions: UiAndBlocActions.Verify , msg: e.msg);
  }
  if (e is UnknownErrorException) {
    return ServerFailure(
      actions: UiAndBlocActions.ShowUnknownError,
      msg: e.msg
    );
  }

  return ServerFailure(
    actions: UiAndBlocActions.ShowError,
    msg: 'Unknown error $e',
  );
}
