import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:silahan_kawan/theme.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonBaseFull extends StatelessWidget {
  const ButtonBaseFull(
      {super.key,
      required this.function,
      required this.title,
      this.shadowOn = true});
  final VoidCallback function;
  final String title;
  final bool shadowOn;

  @override
  Widget build(BuildContext context) {
    TextScaler textScaleFactor = MediaQuery.of(context).textScaler;
    return InkWell(
      onTap: function,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        decoration: ShapeDecoration(
          color: bgBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: [
            shadowOn
                ? BoxShadow(
                    color: Color(0x72F90716),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                : BoxShadow()
          ],
        ),
        child: Center(
            child: Text(
          title,
          textScaler: textScaleFactor,
          style: TextStyle(color: bgWhite, fontWeight: Config.semiBold),
        )),
      ),
    );
  }
}

class ButtonBaseBorder extends StatelessWidget {
  const ButtonBaseBorder(
      {super.key, required this.function, required this.title});
  final VoidCallback function;
  final String title;

  @override
  Widget build(BuildContext context) {
    TextScaler textScaleFactor = MediaQuery.of(context).textScaler;
    return InkWell(
      onTap: function,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        decoration: ShapeDecoration(
          color: bgWhite,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: bgBlue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
            child: Text(
          title,
          textScaler: textScaleFactor,
          style: TextStyle(color: bgBlue, fontWeight: Config.semiBold),
        )),
      ),
    );
  }
}
