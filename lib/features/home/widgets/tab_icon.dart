import 'package:clutch/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabIcon extends StatelessWidget {
  final String icon;
  final String? activeIcon;
  final bool isActive;
  const TabIcon({
    super.key,
    required this.icon,
    this.activeIcon,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(  
      activeIcon ?? icon,
      colorFilter: ColorFilter.mode(
        isActive ? AppColors.primary : AppColors.greyTexy,
        BlendMode.srcIn,
      ),
      height: 20,
    );
  }
}
