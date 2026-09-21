import 'package:clutch/core/datasrc/local/token_local_datasrc.dart';
import 'package:clutch/core/sl.dart';
import 'package:clutch/core/theme/app_theme.dart';
import 'package:clutch/core/utils/bloc_observer.dart';
import 'package:clutch/core/utils/first_screen.dart';
import 'package:clutch/core/utils/shared_pref_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer  = AppBlocObserver();
  await TokenLocalDatasrc().getAccessToken();
  await CacheHelper().init();
  setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppTheme.mainTheme, debugShowCheckedModeBanner: false, home: FIRST_SCREEN());
  }
}