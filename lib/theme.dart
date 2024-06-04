import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

//theme color
Color bgRed = Color(0xffDC3545);
Color bgYellow = Color(0xffFAC153);
Color bgGreen = Color(0xff5cb85c);

Color basicBlack = Color(0xff424242);
Color basicColor = Color(0xff1e7816);
Color bgGeneral = Color(0xffECECEC);
Color trueBlack = Color(0xff000000);
Color bgGrey = const Color(0xff808080);
Color bgGreyLite = Color(0xffb5b5b5);
Color semiGrey = Color(0xff877C7C);
Color trueLove = Color(0xffFF0019);
Color yellowMap = Color(0xffBFC300);

Color bgBlue = const Color(0xff004d91);
Color buttonColor = const Color(0xFF0063F7);
Color bgWhite = const Color(0xffFFFFFF);
Color bgAppbar = const Color(0xff0053CE);
TextStyle regularStyle = const TextStyle();

double iconSize = 24;
double textSmall = 10;
double textMedium = 12;
double textBig = 14;
double textBiggest = 16;
double iconAppbar = 20;

class Config {
  static Color bgAppbar = const Color(0xff0053CE);
  Config();

  static ThemeData getTheme() {
    return ThemeData(
      fontFamily: 'Poppins',
      primaryColor: bgWhite,
      brightness: Brightness.light,
      highlightColor: Colors.white,
      scaffoldBackgroundColor: bgWhite,
      backgroundColor: bgWhite,
      dialogBackgroundColor: bgWhite,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle:
            TextStyle(color: bgWhite, fontSize: 12, backgroundColor: bgWhite),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          disabledBackgroundColor: const Color(0xFFA0A3BD),
          backgroundColor: const Color(0xFF0063F7),
          minimumSize: Size.fromHeight(41),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: const BorderSide(
          color: Color(0xFFD9DBE9),
          width: 2.5,
        ),
        fillColor: const MaterialStatePropertyAll(null),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: bgWhite,
        surfaceTintColor: bgWhite,
        dragHandleColor: const Color(0xFF051923).withOpacity(0.1),
        dragHandleSize: Size(47, 5),
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
      ),
    );
  }

  //FONTWEIGHT
  static FontWeight light = FontWeight.w300;
  static FontWeight reguler = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semiBold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
  static FontWeight verryBold = FontWeight.w800;

  //COLOR
  static Color appbBarBackgroundColor = Colors.blue;
}

// theme color
Color greenColor = const Color(0xff4fc65b);
Color green2Color = const Color(0xff14AF73);
Color blue3Color = const Color(0xff118AD9);
Color blue2Color = const Color(0xff116ACC);
Color blueColor = const Color(0xff2196f3);
Color whiteColor = const Color(0xffffffff);
Color blackColor = const Color(0xff11192A);
Color greyBoldColor = const Color(0xff696060);
Color greyLightColor = const Color(0xffADADAD);
Color grey35Color = const Color(0x59989898);
Color grey2Color = const Color(0xffE8E5E5);
Color blackColor2 = const Color(0xff38414C);
const Color redColor = Color(0xFFFF0022);
const Color dangerDefault = Color(0xFFFF0022);
const Color dangerBgWeak = Color(0xFFFFF2F4);
const Color primaryStrong = Color(0xFF0053CE);
const Color primaryDefault = Color(0xFF0063F7);
const Color primaryBgWeak = Color(0xFFEFF5FF);
const Color headerWeak = Color(0xFF14142B);
const Color bgDefault = Color(0xFFFAFAFA);
const Color generalLine = Color(0xFFD9DBE9);
const Color successDefaultStrong = Color(0xFF017A40);
const Color successDefaultWeak = Color(0xFF53CE93);
const Color successBgWeak = Color(0xFFEEFFF7);
const Color warningDefaultStrong = Color(0xFFB99000);
const Color warningBgWeak = Color(0xFFFFFAE8);
const Color generalBgWeak = Color(0xFFF7F7FC);
const Color generalLabel = Color(0xFF6E7191);
const Color generalBody = Color(0xFF4E4B66);
const Color generalGrey = Color(0xFFA0A3BD);
const Color generalPlaceholder = Color(0xFFA0A3BD);

class MyTextStyle {
  static const TextStyle interTextStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.normal,
  );
}
