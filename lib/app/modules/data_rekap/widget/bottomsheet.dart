import 'package:flutter/material.dart';
import 'package:silahan_kawan/theme.dart';

class BottomSheetAction extends StatelessWidget {
  final String title;
  final Color titleColor;
  final IconData icon;
  final Color iconColor;
  final void Function()? onTap;

  const BottomSheetAction({
    super.key,
    required this.title,
    this.titleColor = Colors.black,
    required this.icon,
    this.iconColor = Colors.black,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 12),
      child: InkWell(
        onTap: onTap ?? () {},
        child: Column(
          children: [
            Row(children: [
              Icon(
                icon,
                size: 24,
                color: bgRed,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: titleColor,
                ),
              ),
            ]),
            Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
