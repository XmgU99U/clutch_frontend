import 'package:clutch/core/network/api_consumer.dart';
import 'package:clutch/core/network/http_consumer.dart';
import 'package:clutch/features/auth/datasrc/remote/auth_datasrc.dart';
import 'package:clutch/features/auth/repo/auth_repo.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void setup() {
  sl.registerSingleton<ApiConsumer>(HttpConsumer());
  sl.registerLazySingleton<AuthDatasrc>(
    () => AuthDatasrcImpl(api: sl<ApiConsumer>()),
  );
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(authDatasrc: sl<AuthDatasrc>()),
  );
}
