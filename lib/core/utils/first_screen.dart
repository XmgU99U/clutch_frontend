import 'package:clutch/core/datasrc/local/token_local_datasrc.dart';
import 'package:clutch/features/auth/screens/get_started_screen.dart';
import 'package:clutch/features/home/screens/index_screen.dart';
import 'package:flutter/material.dart';

Widget FIRST_SCREEN() {
  if (TokenLocalDatasrc().accessToken != null) {
    return const IndexScreen();
  }

  return const GetStartedScreen();
}
