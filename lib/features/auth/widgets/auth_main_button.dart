import 'package:clutch/core/constants/app_fonts.dart';
import 'package:clutch/core/constants/lottie_animations.dart';
import 'package:clutch/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AuthMainButton extends StatelessWidget {
  final bool isLoading;
  final String loadingText;
  final String text;
  final bool? isEnabled; 
  final void Function()? onPressed;
  const AuthMainButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.isLoading,
    required this.loadingText, this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 51,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: (isLoading || isEnabled == false)
          ? const Color.fromARGB(255, 136, 174, 48)
          : AppColors.primary,
      highlightColor: const Color.fromARGB(255, 143, 181, 53),
      splashColor: AppColors.primary,
      onPressed: onPressed,
      minWidth: double.infinity,
      child: isLoading
          ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(LottieAnimations.buttonLoading, height: 40),
              Text(
                  loadingText,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: AppFonts.barlowCondensed,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          )
          : Text(
               text,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: AppFonts.barlowCondensed,
                fontWeight: FontWeight.w700,
              ),
            ),
    );
  }
}
