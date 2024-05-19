import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final InputBorder? border;
  final Icon prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(dynamic value) validator;
  final bool obscureText;
  final bool autocorrect;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.border,
    required this.prefixIcon,
    this.suffixIcon,
    required this.keyboardType,
    required this.textInputAction,
    required this.validator,
    this.obscureText = false,
    this.autocorrect = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: autocorrect,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        filled: true,
        border: border ??
            UnderlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
        errorMaxLines: 2,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
    );
  }
}
