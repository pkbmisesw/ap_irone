import 'package:flutter/material.dart';
import 'package:silahan_kawan/app/widgets/dialog/custom_dialog.dart';

class ItemMenuDB {
  final int id;
  final String title;
  final IconData? icon;
  final String? assetsImg;
  final String? image;
  final String? routeName;
  final CustomDialog? widgetPopup;
  final String? imagePath;
  final Color? color;

  const ItemMenuDB(
      {required this.id,
      required this.title,
      this.icon,
      this.assetsImg,
      this.image,
      this.routeName,
      this.widgetPopup,
      this.imagePath, // Parameter baru
      this.color});
}
