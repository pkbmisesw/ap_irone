import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final Widget? title;
  final TextStyle? titleTextStyle;
  final Widget? content;
  final TextStyle? contentTextStyle;
  final Widget? icon;
  final List<Widget>? actions;

  const CustomDialog({
    this.title,
    this.titleTextStyle,
    this.content,
    this.contentTextStyle,
    this.icon,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      actions: actions,
      icon: icon,
      titleTextStyle: titleTextStyle,
      content: content,
      contentTextStyle: contentTextStyle,
    );
  }
}
