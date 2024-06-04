import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/modules/data_rekap/widget/sizedbox_extension.dart';
import 'package:silahan_kawan/theme.dart';

class ConfirmDialog extends StatelessWidget {
  final IconData headerIcon;
  final Color? headerIconColor;
  final String headerText;
  final Widget? body;
  final String? cancelLabel;
  final String? applyLabel;
  final Function()? onCancel;
  final Function()? onApply;
  final ButtonStyle? applyStyle;
  final bool noGetback;

  const ConfirmDialog({
    super.key,
    required this.headerIcon,
    this.headerIconColor,
    required this.headerText,
    this.body,
    this.cancelLabel,
    this.applyLabel,
    this.onCancel,
    this.onApply,
    this.applyStyle,
    this.noGetback = false,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              headerIcon,
              size: 20,
              color: headerIconColor ?? bgRed,
            ),
            SizedBox(width: 9.34),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    headerText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: bgRed,
                    ),
                  ),
                  6.heightBox,
                  body ?? const SizedBox(),
                  12.heightBox,
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(child: SizedBox()),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  if (onApply != null) {
                    if (onApply is Future<dynamic> Function()) {
                      await onApply!();
                    } else {
                      onApply!();
                    }
                  }
                  noGetback ? null : Get.back();
                },
                style: applyStyle?.merge(
                      ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: bgRed,
                        minimumSize: Size.fromHeight(41),
                      ),
                    ) ??
                    ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: bgRed,
                      minimumSize: Size.fromHeight(41),
                    ),
                child: Text(
                  applyLabel ?? 'Yes',
                  style: TextStyle(color: bgWhite),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
