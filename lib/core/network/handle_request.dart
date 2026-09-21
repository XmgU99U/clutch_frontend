import 'package:clutch/core/api_errors/exceptions.dart';
import 'package:clutch/core/network/response.dart';

Future<T> HANDLE_REQUEST<T>(
  Future<Response> request,
  T Function(Map<String, dynamic>?) handleSuccessCase,
) async {
  final res = await request;
  if (res.statusCode >= 200 && res.statusCode <= 300) {
    return handleSuccessCase(res.body);
  }
  // start handling every case
  if (res.body == null) {
    throw UnknownErrorException(msg: 'Unknown error: ${res.statusCode}');
  }

  final String? errorCode = res.body?['detail']['code'];
  final String? errorMsg = res.body!['detail']['msg'];

  if (errorCode == null && errorMsg == null) {
    print(res.body);
    throw UnknownErrorException(msg: 'Unknown response: ${res.statusCode} ');
  }

  switch (errorCode) {
    case 'INVALID_INPUT':
      throw InvalidInputException(msg: errorMsg!);

    case 'INVALID_CREDENTIALS':
      throw InvaliCredentialsException(msg: errorMsg!);

    case 'RATE_LIMITED':
      throw RateLimitedException(msg: 'RATE_LIMITED');

    case 'INVALID_TOKEN':
      throw InvalidTokenException(msg: 'INVALID_TOKEN');

    case 'TOKEN_EXPIRED':
      throw ExpiredTokenException(msg: 'TOKEN_EXPIRED');

    case 'NOT_AUTHORIZED':
      throw NotAuthorizedException(msg: errorMsg!);

    case 'NOT_FOUND':
      throw NotFoundException(msg: errorMsg!);

    case 'UNVERIFIED_USER':
      throw UnverifiedUserException(msg: errorMsg!);

    default:
      print(errorCode);
      print(errorMsg);
      throw UnknownErrorException(
        msg: 'Unhandled case: code = $errorCode | msg = $errorMsg',
      );
  }
}
