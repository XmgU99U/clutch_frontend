import 'package:clutch/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  const Circle({
    super.key,
    required this.text,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      padding: const EdgeInsets.all(8),
      child:  Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 10,
          fontFamily: AppFonts.jetBrainsMono,
        ),
      ),
    );
  }
}
