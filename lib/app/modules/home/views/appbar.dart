import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';

class AppBarUniversal extends StatelessWidget implements PreferredSizeWidget {
  const AppBarUniversal({Key? key, required this.title, this.color})
      : super(key: key);
  final Color? color;
  final String title;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      elevation: 2,
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Remix.arrow_left_line,
          color: color ?? Color(0xffB00020),
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: color ?? Color(0xffB00020),
        ),
      ),
    );
  }
}
