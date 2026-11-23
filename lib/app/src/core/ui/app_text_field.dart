import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.textInputAction,
  });

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          textInputAction: textInputAction,
          style: const TextStyle(color: AppColors.text),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.hint, fontSize: 14),
            prefixIcon: Icon(prefixIcon, color: AppColors.hint),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.fieldFill,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            enabledBorder: _border(AppColors.fieldBorder),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(Colors.red),
            focusedErrorBorder: _border(Colors.red),
          ),
        ),
      ],
    );
  }
}