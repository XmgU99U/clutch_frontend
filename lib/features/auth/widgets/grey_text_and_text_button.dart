import 'package:clutch/core/constants/app_fonts.dart';
import 'package:clutch/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GreyTextAndTextButton extends StatelessWidget {
  final String greyText;
  final String buttonText;
  final void Function() onTap;
  const GreyTextAndTextButton({
    super.key,
    required this.greyText,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          greyText,
          style: const TextStyle(
            fontFamily: AppFonts.jetBrainsMono,
            fontSize: 12,
            color: AppColors.greyTexy,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            buttonText,
            style: const TextStyle(
              fontFamily: AppFonts.jetBrainsMono,
              fontSize: 12,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
