import 'package:clutch/core/constants/app_urls.dart';
import 'package:clutch/core/network/api_consumer.dart';
import 'package:clutch/core/network/handle_request.dart';
import 'package:clutch/core/sl.dart';

class TokenRemoteDatasrc {
  final api = sl<ApiConsumer>();
  static TokenRemoteDatasrc? _instance;

  TokenRemoteDatasrc._internal();

  factory TokenRemoteDatasrc() {
    _instance ??= TokenRemoteDatasrc._internal();
    return _instance!;
  }

  Future<String> refresh({required String refreshToken}) async {
    return HANDLE_REQUEST<String>(
      api.post(AppUrls.refresh , body: {'refreshToken' : refreshToken}),
      (resBody) => resBody!['accessToken'],
    );
  }
}
