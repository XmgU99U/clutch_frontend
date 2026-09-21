import 'package:clutch/core/constants/app_fonts.dart';
import 'package:clutch/core/network/api_state.dart';
import 'package:clutch/core/theme/app_colors.dart';
import 'package:clutch/core/utils/extension_on_build_context.dart';
import 'package:clutch/features/auth/bloc/auth_cubit.dart';
import 'package:clutch/features/auth/screens/step_2_screen.dart';
import 'package:clutch/features/auth/widgets/auth_back_button.dart';
import 'package:clutch/features/auth/widgets/auth_main_button.dart';
import 'package:clutch/features/auth/widgets/auth_text_field.dart';
import 'package:clutch/features/auth/widgets/circle.dart';
import 'package:clutch/features/auth/widgets/line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Step1Screen extends StatefulWidget {
  const Step1Screen({super.key});

  @override
  State<Step1Screen> createState() => _Step1ScreenState();
}

class _Step1ScreenState extends State<Step1Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp gamerTagRexep = RegExp(r'^[a-zA-Z0-9_\-]{4,16}$');
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
                        text: '1',
                        color: AppColors.primary,
                        textColor: Colors.black,
                      ),
                      SizedBox(width: 10),
                      Line(color: AppColors.greyTexy),
                      SizedBox(width: 10),
                      Circle(
                        text: '2',
                        color: AppColors.greyTexy,
                        textColor: Colors.grey,
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
                    'WHO ARE YOU?',
                    style: TextStyle(
                      fontSize: 39,
                      fontWeight: FontWeight.w900,
                      color: AppColors.whiteText,
                      fontFamily: AppFonts.barlowCondensed,
                    ),
                  ),
                  const Text(
                    'Set up your gaming identity',
                    style: TextStyle(color: AppColors.greyTexy),
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<AuthCubit, ApiState>(
                    builder: (context, state) => AuthTextField(
                      labelText: 'G A M E R T A G',
                      hintText: '#XmgU9',
                      errorText: state is ApiFailureState ? state.msg : null,
                      controller: context.read<AuthCubit>().gamerTag,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Can't be empty";
                        }
                        if (!gamerTagRexep.hasMatch(value)) {
                          return 'Not valid gamertag';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: context.deviceHeight * 0.5),
                  AuthMainButton(
                    isLoading: false,
                    loadingText: '',
                    text: 'CONTINUE',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.push(
                          BlocProvider.value(
                            value: context.read<AuthCubit>(),
                            child: const Step2Screen(),
                          ),
                        );
                      }
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
