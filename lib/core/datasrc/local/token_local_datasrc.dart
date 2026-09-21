import 'package:clutch/core/constants/app_keys.dart';
import 'package:clutch/core/utils/secure_storage_handler.dart';

class TokenLocalDatasrc {
  static TokenLocalDatasrc? _instance;
  String? accessToken;

  TokenLocalDatasrc._internal();

  factory TokenLocalDatasrc() {
    _instance ??= TokenLocalDatasrc._internal();
    return _instance!;
  }
  Future<void> storeTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await SecureStorageHandler().write(
      key: AppKeys.accessToken,
      value: accessToken,
    );
    await SecureStorageHandler().write(
      key: AppKeys.refreshToken,
      value: refreshToken,
    );
    print('token stored in secure storage');
    print('access token: $accessToken');
    print('refresh token: $refreshToken');
  }

  Future<void> storeAccessToken(String accessToken) async {
    await SecureStorageHandler().write(
      key: AppKeys.accessToken,
      value: accessToken,
    );
    print('token stored in secure storage');
    print('access token: $accessToken');
  }

  Future<String?> getAccessToken() async {
    final String? accessToken = await SecureStorageHandler().read(
      AppKeys.accessToken,
    );
    this.accessToken = accessToken;
    return accessToken;
  }

  Future<String?> getRefreshToken() async {
    return await SecureStorageHandler().read(AppKeys.refreshToken);
  }
}
