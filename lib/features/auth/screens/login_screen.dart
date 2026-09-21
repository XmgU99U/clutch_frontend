import 'package:clutch/core/constants/app_fonts.dart';
import 'package:clutch/core/constants/app_regexs.dart';
import 'package:clutch/core/enums/ui_and_bloc_actions.dart';
import 'package:clutch/core/network/api_state.dart';
import 'package:clutch/core/sl.dart';
import 'package:clutch/core/theme/app_colors.dart';
import 'package:clutch/core/utils/extension_on_build_context.dart';
import 'package:clutch/core/widgets/no_internet.dart';
import 'package:clutch/features/auth/bloc/auth_cubit.dart';
import 'package:clutch/features/auth/repo/auth_repo.dart';
import 'package:clutch/features/auth/screens/step_1_screen.dart';
import 'package:clutch/features/auth/screens/verify_code_screen.dart';
import 'package:clutch/features/auth/widgets/auth_back_button.dart';
import 'package:clutch/features/auth/widgets/auth_main_button.dart';
import 'package:clutch/features/auth/widgets/auth_text_field.dart';
import 'package:clutch/features/auth/widgets/grey_text_and_text_button.dart';
import 'package:clutch/features/home/screens/index_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthBackButton(),
                  const SizedBox(height: 20),
                  const Text(
                    'SECURE IT',
                    style: TextStyle(
                      fontSize: 39,
                      fontWeight: FontWeight.w900,
                      color: AppColors.whiteText,
                      fontFamily: AppFonts.barlowCondensed,
                    ),
                  ),
                  const Text(
                    'Your email and password stay private',
                    style: TextStyle(color: AppColors.greyTexy),
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<AuthCubit, ApiState>(
                    builder: (context, state) => AuthTextField(
                      errorText: (state is ApiFailureState && state.action != UiAndBlocActions.ShowNoInternet) ? state.msg : null,
                      labelText: 'E M A I L',
                      hintText: 'you@gmail.com',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Can't be empty";
                        }
                        if (!AppRegexs.emailRegex.hasMatch(value)) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                      controller: context.read<AuthCubit>().userEmail,
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthCubit, ApiState>(
                    builder: (context, state) => AuthTextField(
                      errorText: (state is ApiFailureState && state.action != UiAndBlocActions.ShowNoInternet) ? state.msg : null,
                      labelText: 'P A S S W O R D',
                      hintText: '.  .  .  .  .  .  .  .',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Can't be empty";
                        }
                        if (!AppRegexs.passRegex.hasMatch(value)) {
                          return 'Invalid password';
                        }
                        return null;
                      },
                      obsecureText: true,
                      controller: context.read<AuthCubit>().userPassword,
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthCubit, ApiState>(
                    builder: (context, state) {
                      if (state is ApiFailureState &&
                          state.action == UiAndBlocActions.ShowNoInternet) {
                        return const NoInternet();
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  SizedBox(height: context.deviceHeight * 0.35),
                  BlocConsumer<AuthCubit, ApiState>(
                    builder: (context, state) => AuthMainButton(
                      isLoading: state is ApiLoadingState,
                      loadingText: 'LOGGING IN',
                      text: 'LOG IN',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login();
                        }
                      },
                    ),
                    listener: (context, state) {
                      if (state is ApiFailureState &&
                          state.action == UiAndBlocActions.Verify) {
                        context.push(
                          BlocProvider.value(
                            value: context.read<AuthCubit>(),
                            child: const VerifyCodeScreen(
                              isCreatingAccount: false,
                            ),
                          ),
                        );
                      }
                      if (state is ApiSuccessState) {
                        context.pushAndRemoveAll(const IndexScreen());
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  GreyTextAndTextButton(
                    greyText: 'No Account? ',
                    buttonText: 'Sign up',
                    onTap: () {
                      context.replace(
                        BlocProvider(
                          create: (_) =>
                              AuthCubit(authRepo: sl<AuthRepo>()),
                          child: const Step1Screen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
