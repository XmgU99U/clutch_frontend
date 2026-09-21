import 'package:clutch/core/constants/app_fonts.dart';
import 'package:clutch/core/constants/app_images.dart';
import 'package:clutch/core/sl.dart';
import 'package:clutch/core/theme/app_colors.dart';
import 'package:clutch/core/utils/extension_on_build_context.dart';
import 'package:clutch/features/auth/bloc/auth_cubit.dart';
import 'package:clutch/features/auth/repo/auth_repo.dart';
import 'package:clutch/features/auth/screens/login_screen.dart';
import 'package:clutch/features/auth/screens/step_1_screen.dart';
import 'package:clutch/features/auth/widgets/auth_main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E0E0D),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(AppImages.getStartedImage),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: double.infinity),
              const Text(
                'CLUTCH',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 52,
                  fontWeight: FontWeight.w900,
                  fontFamily: AppFonts.barlowCondensed,
                ),
              ),
              const Text(
                ' B E T A',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 9,
                  fontFamily: AppFonts.jetBrainsMono,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Own your game.',
                style: TextStyle(
                  color: AppColors.whiteText,
                  fontFamily: AppFonts.barlowCondensed,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Settings, screenshots, clips — all in\n one place.',
                style: TextStyle(color: AppColors.greyTexy),
              ),
              const SizedBox(height: 20),
              AuthMainButton(
                isLoading: false, 
                loadingText: '',
                text: 'CREATE ACCOUNT',
                onPressed: () => context.push(
                  BlocProvider(
                    create: (_) => AuthCubit(authRepo: sl<AuthRepo>()),
                    child: const Step1Screen(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              MaterialButton(
                height: 51,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: AppColors.secondary,
                highlightColor: const Color.fromARGB(255, 18, 18, 17),
                splashColor: AppColors.secondary,
                onPressed: () => context.push(
                  BlocProvider(
                    create: (_) => AuthCubit(authRepo: sl<AuthRepo>()),
                    child: const LoginScreen(),
                  ),
                ),
                minWidth: double.infinity,
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    color: AppColors.whiteText,
                    fontFamily: AppFonts.barlowCondensed,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'By continuing you agree to our Terms & Privacy Policy',
                style: TextStyle(
                  fontFamily: AppFonts.jetBrainsMono,
                  color: AppColors.extraGreyText,
                  fontSize: 9,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
