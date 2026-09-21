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
import 'package:clutch/features/auth/screens/login_screen.dart';
import 'package:clutch/features/auth/screens/verify_code_screen.dart';
import 'package:clutch/features/auth/widgets/auth_back_button.dart';
import 'package:clutch/features/auth/widgets/auth_main_button.dart';
import 'package:clutch/features/auth/widgets/auth_text_field.dart';
import 'package:clutch/features/auth/widgets/circle.dart';
import 'package:clutch/features/auth/widgets/grey_text_and_text_button.dart';
import 'package:clutch/features/auth/widgets/line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Step2Screen extends StatefulWidget {
  const new({super.key});

  @override
  State<Step2Screen> createState() => _Step2ScreenState();
}

class _Step2ScreenState extends State<Step2Screen> {
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
                  const Row(
                    children: [
                      Circle(
                        text: '✓',
                        color: AppColors.primary,
                        textColor: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Line(color: AppColors.primary),
                      SizedBox(width: 10),
                      Circle(
                        text: '2',
                        color: AppColors.primary,
                        textColor: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Line(color: AppColors.greyTexy),
                      SizedBox(width: 10),
                      Circle(
                        text: '3',
                        color: AppColors.greyTexy,
                        textColor: Colors.grey,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Your identity',
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: AppFonts.jetBrainsMono,
                          color: AppColors.greyTexy,
                        ),
                      ),
                    ],
                  ),
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
                      labelText: 'E M A I L',
                      errorText:
                          (state is ApiFailureState &&
                              state.action != UiAndBlocActions.ShowNoInternet)
                          ? state.msg
                          : null,
                      hintText: 'you@gmail.com',
                      controller: context.read<AuthCubit>().userEmail,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Can't be empty";
                        }
                        if (!AppRegexs.emailRegex.hasMatch(value)) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthCubit, ApiState>(
                    builder: (context, state) => AuthTextField(
                      errorText:
                          (state is ApiFailureState &&
                              state.action != UiAndBlocActions.ShowNoInternet)
                          ? state.msg
                          : null,
                      labelText: 'P A S S W O R D',
                      obsecureText: true,
                      hintText: 'Min. 8 characters',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Can't be empty";
                        }
                        if (!AppRegexs.passRegex.hasMatch(value)) {
                          return 'Invalid Password';
                        }
                        return null;
                      },
                      controller: context.read<AuthCubit>().userPassword,
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthCubit, ApiState>(
                    builder: (context, state) {
                      if (state is ApiFailureState &&
                          state.action == UiAndBlocActions.ShowNoInternet) {
                        const NoInternet();
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  SizedBox(height: context.deviceHeight * 0.35),
                  BlocConsumer<AuthCubit, ApiState>(
                    builder: (context, state) => AuthMainButton(
                      isLoading: state is ApiLoadingState,
                      loadingText: 'SENDING CODE',
                      text: 'SEND VERIFICATION CODE',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await context.read<AuthCubit>().register();
                        }
                      },
                    ),
                    listener: (context, state) {
                      if (state is ApiFailureState &&
                          state.msg == 'gamertag already in use') {
                        context.back();
                      }
                      if (state is ApiSuccessState) {
                        context.push(
                          BlocProvider.value(
                            value: context.read<AuthCubit>(),
                            child: const VerifyCodeScreen(
                              isCreatingAccount: true,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  GreyTextAndTextButton(
                    greyText: 'Already Have an Account? ',
                    buttonText: 'Log in',
                    onTap: () {
                      context.back();
                      context.replace(
                        BlocProvider(
                          create: (_) => AuthCubit(authRepo: sl<AuthRepo>()),
                          child: const LoginScreen(),
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
