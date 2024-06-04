import 'package:silahan_kawan/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyField extends StatelessWidget {
  BodyField(
      {super.key,
      required this.controller,
      required this.fuction,
      required this.hint,
      required this.title,
      this.icon,
      this.boolIsNoBorder = false,
      required this.validator,
      this.isObscure = false});
  final String title;
  final String hint;
  final VoidCallback fuction;
  final TextEditingController controller;
  final Widget? icon;
  final bool boolIsNoBorder;
  final String? Function(dynamic value) validator;

  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextField(
          onChanged: fuction,
          controller: controller,
          hintText: hint,
          obscureText: false,
          boolIsNoBorder: boolIsNoBorder,
          prefixIcon: icon,
          validator: validator,
          isObscure: isObscure,
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  final Function()? onChanged;
  final bool isObscure;
  final List<TextInputFormatter>? inputFormatters;
  final bool boolIsNoBorder;
  final String? Function(dynamic value) validator;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.prefixIcon,
      this.onChanged,
      this.isObscure = false,
      this.inputFormatters,
      this.boolIsNoBorder = false,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            hintText: hintText,
            errorBorder: const UnderlineInputBorder(),
            focusedErrorBorder: const UnderlineInputBorder(),
            enabledBorder: boolIsNoBorder
                ? const UnderlineInputBorder()
                : const OutlineInputBorder(),
            contentPadding: const EdgeInsets.all(10),
            hintStyle: const TextStyle(
              fontSize: 15,
              color: Color(0xff8d8d8d),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: bgBlue),
            ),
            suffixIcon: prefixIcon),
        validator: validator,
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  const MyButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      this.textColor,
      this.borderColor,
      this.bgColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Container(
          height: 45,
          width: 275,
          decoration: BoxDecoration(
              color: bgColor ?? const Color(0xff0B6EFE),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: borderColor ?? Colors.transparent, width: 2)),
          child: Center(
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
