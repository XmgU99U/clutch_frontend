import 'package:clutch/core/constants/app_fonts.dart';
import 'package:clutch/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final bool obsecureText;
  final String? Function(String?)? validator;
  final String? errorText; 
  const AuthTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.obsecureText = false,
    this.validator, this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obsecureText,
      style: const TextStyle(fontSize: 13),
      cursorColor: const Color.fromARGB(255, 230, 250, 184),
      decoration: InputDecoration(
        errorText: errorText,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // Updates color dynamically while the label stays at the top
        floatingLabelStyle: WidgetStateTextStyle.resolveWith((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.focused)) {
            return const TextStyle(
              color: AppColors.primary,
              fontFamily: AppFonts.barlowCondensed,
            );
          }
          // Color used when the label is up but the field is NOT focused
          return const TextStyle(
            color: AppColors.greyTexy,
            fontFamily: AppFonts.barlowCondensed,
          );
        }),
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.greyTexy, fontSize: 13),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyTexy),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
