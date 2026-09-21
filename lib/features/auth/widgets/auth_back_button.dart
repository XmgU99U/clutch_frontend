import 'package:clutch/core/constants/app_fonts.dart';
import 'package:clutch/core/theme/app_colors.dart';
import 'package:clutch/core/utils/extension_on_build_context.dart';
import 'package:flutter/material.dart';

class AuthBackButton extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.back(),
      child: const Row(
        children: [
          Icon(Icons.arrow_back_ios, size: 18, color: AppColors.greyTexy),
          Text(
            'Back',
            style: TextStyle(
              fontSize: 12,
              fontFamily: AppFonts.jetBrainsMono,
              color: AppColors.greyTexy,
            ),
          ),
        ],
      ),
    );
  }
}
