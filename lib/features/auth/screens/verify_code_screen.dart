import 'package:clutch/core/constants/app_fonts.dart';
import 'package:clutch/core/network/api_state.dart';
import 'package:clutch/core/theme/app_colors.dart';
import 'package:clutch/core/utils/extension_on_build_context.dart';
import 'package:clutch/features/auth/bloc/auth_cubit.dart';
import 'package:clutch/features/auth/widgets/auth_back_button.dart';
import 'package:clutch/features/auth/widgets/auth_main_button.dart';
import 'package:clutch/features/auth/widgets/circle.dart';
import 'package:clutch/features/auth/widgets/grey_text_and_text_button.dart';
import 'package:clutch/features/auth/widgets/line.dart';
import 'package:clutch/features/home/screens/index_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerifyCodeScreen extends StatefulWidget {
  final bool isCreatingAccount;
  const VerifyCodeScreen({super.key, required this.isCreatingAccount});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool isEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthBackButton(),
                const SizedBox(height: 20),
                widget.isCreatingAccount
                    ? const Row(
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
                            text: '✓',
                            color: AppColors.primary,
                            textColor: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Line(color: AppColors.primary),
                          SizedBox(width: 10),
                          Circle(
                            text: '3',
                            color: AppColors.primary,
                            textColor: Colors.black,
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
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 20),
                const Text(
                  'CHECK YOUR EMAIL',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: AppColors.whiteText,
                    fontFamily: AppFonts.barlowCondensed,
                  ),
                ),
                const Text(
                  'We sent a 6-digit code to',
                  style: TextStyle(color: AppColors.greyTexy),
                ),
                Text(context.read<AuthCubit>().userEmail.text),
                const SizedBox(height: 30),
                BlocBuilder<AuthCubit, ApiState>(
                  builder: (context, state) => OtpTextField(
                    numberOfFields: 6,
                    showFieldAsBox: true,
                    borderRadius: BorderRadius.circular(12),
                    fillColor: const Color(0xff222222),
                    enabledBorderColor:
                        (state is ApiFailureState &&
                            state.msg != 'Plz verify your email')
                        ? AppColors.errorText
                        : const Color(0xff363635),
                    focusedBorderColor: AppColors.primary,
                    filled: true,
                    cursorColor: AppColors.primary,
                    borderWidth: 1,
                    onSubmit: (code) {
                      context.read<AuthCubit>().code = int.parse(code);
                      setState(() {
                        isEnabled = true;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                BlocBuilder<AuthCubit, ApiState>(
                  builder: (context, state) {
                    if (state is ApiFailureState &&
                        state.msg != 'Plz verify your email') {
                      return Center(
                        child: Text(
                          state.msg,
                          style: const TextStyle(
                            fontFamily: AppFonts.jetBrainsMono,
                            color: AppColors.errorText,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 30),
                GreyTextAndTextButton(
                  greyText: "Didn't get it ",
                  buttonText: "Resend code",
                  onTap: () {},
                ),
                SizedBox(height: context.deviceHeight * 0.4),
                BlocConsumer<AuthCubit, ApiState>(
                  builder: (context, state) => AuthMainButton(
                    isEnabled: isEnabled,
                    text: 'VERIFY & JOIN',
                    isLoading: state is ApiLoadingState,
                    loadingText: 'VERIFYING',
                    onPressed: () {
                      if (isEnabled) {
                        context.read<AuthCubit>().verifyEmail(
                          code: context.read<AuthCubit>().code!,
                        );
                      }
                    },
                  ),
                  listener: (context, state) {
                    if(state is ApiSuccessState) {
                      context.pushAndRemoveAll(const IndexScreen());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
