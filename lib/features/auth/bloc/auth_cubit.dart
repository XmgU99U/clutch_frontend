import 'package:clutch/core/network/api_state.dart';
import 'package:clutch/core/utils/handle_failures.dart';
import 'package:clutch/features/auth/repo/auth_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<ApiState> {
  final AuthRepo authRepo;
  final TextEditingController gamerTag = TextEditingController();
  final TextEditingController userEmail = TextEditingController();
  final TextEditingController userPassword = TextEditingController();
  int? code; 
  AuthCubit({required this.authRepo}) : super(ApiInitState());

  Future<void> login() async {
    final res = await authRepo.login(
      userEmail: userEmail.text,
      userPassword: userPassword.text,
    );
    res.fold((failure) {
      final apiFailure = HANDLE_FAILURES(failure);
      emit(ApiFailureState(msg: apiFailure.msg, action: apiFailure.action));
    }, (unit) => emit(ApiSuccessState(data: null)));
  }

  Future<void> register() async {
    emit(ApiLoadingState());
    final res = await authRepo.register(
      gamerTag: gamerTag.text,
      userEmail: userEmail.text,
      userPassword: userPassword.text,
    );
    res.fold((failure) {
      final apiFailure = HANDLE_FAILURES(failure);
      emit(apiFailure);
    }, (unit) => emit(ApiSuccessState(data: null)));
  }

  Future<void> verifyEmail({required int code}) async {
    emit(ApiLoadingState());
    final res = await authRepo.verifyEmail(
      code: code,
      userEmail: userEmail.text,
    );

    res.fold((failure) {
      final apiFailure = HANDLE_FAILURES(failure);
      emit(ApiFailureState(msg: apiFailure.msg, action: apiFailure.action));
    }, (_) => emit(ApiSuccessState(data: null)));
  }

  Future<void> resendVerificationCode() async {
    emit(ApiLoadingState());
    final res = await authRepo.resendVerificationCode(
      userEmail: userEmail.text,
    );
    res.fold((failure) {
      final apiFailure = HANDLE_FAILURES(failure);
      emit(ApiFailureState(msg: apiFailure.msg, action: apiFailure.action));
    }, (_) => emit(ApiSuccessState(data: null)));
  }
}
