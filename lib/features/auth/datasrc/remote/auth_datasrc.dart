import 'dart:convert';

import 'package:clutch/core/constants/app_urls.dart';
import 'package:clutch/core/network/api_consumer.dart';
import 'package:clutch/core/network/handle_request.dart';

abstract class AuthDatasrc {
  // {"accessToken" : "<access token>" , "refreshToken" : "<refresh token>"}
  Future<Map<String, String>> login({
    required String userEmail,
    required String userPassword,
  });

  // string is user email
  Future<String> register({
    required String gamerTag,
    required String userEmail,
    required String userPassword,
  });

  Future<Map<String, String>> verifyEmail({
    required String userEmail,
    required int code,
  });

  Future<void> resendVerificationCode({required String userEmail});

  Future<void> logout({
    required String accessToken,
    required String refreshToken,
  });

  // Future<String> changeProfoleImage({required String accessToken, })
}



class AuthDatasrcImpl implements AuthDatasrc {
  final ApiConsumer api;

  new({required this.api});

  @override
  Future<Map<String, String>> login({
    required String userEmail,
    required String userPassword,
  }) async {
    return await HANDLE_REQUEST<Map<String, String>>(
      api.post(
        AppUrls.login,
        body: jsonEncode({'userEmail': userEmail, 'userPassword': userPassword}),
      ),
      (Map<String, dynamic>? resBody) {
        final String accessToken = resBody!['accessToken'];
        final String refreshToken = resBody['refreshToken'];
        return {'accessToken': accessToken, 'refreshToken': refreshToken};
      },
    );
  }

  @override
  Future<void> logout({
    required String accessToken,
    required String refreshToken,
  }) async {
    return await HANDLE_REQUEST<void>(
      api.delete(
        AppUrls.logout,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({'refreshToken': refreshToken}),
      ),
      (resBody) {},
    );
  }

  @override
  Future<String> register({
    required String gamerTag,
    required String userEmail,
    required String userPassword,
  }) async {
    return await HANDLE_REQUEST<String>(
      api.post(
        AppUrls.register,
        body: jsonEncode({
          'gamerTag': gamerTag,
          'userEmail': userEmail,
          'userPassword': userPassword,
        },)
      ),
      (resBody) => resBody!['userEmail'],
    );
  }

  @override
  Future<void> resendVerificationCode({required String userEmail}) async {
    return await HANDLE_REQUEST<void>(
      api.patch(AppUrls.resendVerificationCode, body: jsonEncode({'userEmail': userEmail})),
      (resBody) {},
    );
  }

  @override
  Future<Map<String, String>> verifyEmail({
    required String userEmail,
    required int code,
  }) async {
    return await HANDLE_REQUEST<Map<String, String>>(
      api.patch(
        AppUrls.verifyEmail,
        body: jsonEncode({'userEmail' : userEmail, 'code' : code})
      ),
      (resBody) {
        final String accessToken = resBody!['accessToken'];
        final String refreshToken = resBody['refreshToken'];
        return {'accessToken': accessToken, 'refreshToken': refreshToken};
      },
    );
  }
}
