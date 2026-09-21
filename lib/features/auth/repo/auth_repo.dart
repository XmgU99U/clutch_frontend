import 'package:clutch/core/api_errors/failures.dart';
import 'package:clutch/core/constants/app_keys.dart';
import 'package:clutch/core/datasrc/local/token_local_datasrc.dart';
import 'package:clutch/core/utils/handle_datasrc_exceptions.dart';
import 'package:clutch/core/utils/has_internet.dart';
import 'package:clutch/core/utils/shared_pref_handler.dart';
import 'package:clutch/features/auth/datasrc/remote/auth_datasrc.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, Unit>> login({
    required String userEmail,
    required String userPassword,
  });

  Future<Either<Failure, Unit>> register({
    required String gamerTag,
    required String userEmail,
    required String userPassword,
  });

  Future<Either<Failure, Unit>> verifyEmail({
    required int code,
    required String userEmail,
  });

  Future<Either<Failure, Unit>> resendVerificationCode({
    required String userEmail,
  });

  Future<Either<Failure, Unit>> logout();
}

class AuthRepoImpl implements AuthRepo {
  final AuthDatasrc authDatasrc;

  new({required this.authDatasrc});
  @override
  Future<Either<Failure, Unit>> login({
    required String userEmail,
    required String userPassword,
  }) async {
    if (await HAS_INTERNET()) {
      try {
        final tokens = await authDatasrc.login(
          userEmail: userEmail,
          userPassword: userPassword,
        );
        TokenLocalDatasrc().storeTokens(
          accessToken: tokens['accessToken']!,
          refreshToken: tokens['refreshToken']!,
        );
        return const Right(unit);
      } catch (e) {
        final failure = await HANDLE_DATASRC_EXCEPTIONS(e);
        return Left(failure);
      }
    }
    return Left(NoInternetFailure());
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    if (await HAS_INTERNET()) {
      try {

        await authDatasrc.logout(
          accessToken: await TokenLocalDatasrc().getAccessToken() as String ,
          refreshToken: await TokenLocalDatasrc().getRefreshToken() as String ,
        );
      } catch (e) {
        final failure = await HANDLE_DATASRC_EXCEPTIONS(e);
        return Left(failure);
      }
    }
    return Left(NoInternetFailure());
  }

  @override
  Future<Either<Failure, Unit>> register({
    required String gamerTag,
    required String userEmail,
    required String userPassword,
  }) async {
    if (await HAS_INTERNET()) {
      try {
        final String email = await authDatasrc.register(
          gamerTag: gamerTag,
          userEmail: userEmail,
          userPassword: userPassword,
        );
        CacheHelper().setString(AppKeys.userEmail, email);
        return const Right(unit);
      } catch (e) {
        final failure = await HANDLE_DATASRC_EXCEPTIONS(e);
        return Left(failure);
      }
    }
    return Left(NoInternetFailure());
  }

  @override
  Future<Either<Failure, Unit>> resendVerificationCode({
    required String userEmail,
  }) async {
    if (await HAS_INTERNET()) {
      try {
        await authDatasrc.resendVerificationCode(userEmail: userEmail);
      } catch (e) {
        final failure = await HANDLE_DATASRC_EXCEPTIONS(e);
        return Left(failure);
      }
    }
    return Left(NoInternetFailure());
  }

  @override
  Future<Either<Failure, Unit>> verifyEmail({
    required int code,
    required String userEmail,
  }) async {
    if (await HAS_INTERNET()) {
      try {
        final tokens = await authDatasrc.verifyEmail(
        userEmail: userEmail,
        code: code,
      );
      TokenLocalDatasrc().storeTokens(
        accessToken: tokens['accessToken']!,
        refreshToken: tokens['refreshToken']!,
      );
      return const Right(unit);
    } catch (e) {
      final failure = await HANDLE_DATASRC_EXCEPTIONS(e);
      return Left(failure);
    }
      }
    return Left(NoInternetFailure());
  }
}
