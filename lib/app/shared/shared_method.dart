import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>|&nbsp;", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

void showSnackbar({
  required String message,
  Color? bgColor,
  Color? textColor,
  Duration duration = const Duration(seconds: 5),
  SnackBarAction? action,
}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: bgColor,
      duration: duration,
      action: action,
      dismissDirection:
          (action != null) ? DismissDirection.none : DismissDirection.down,
    ),
  );
}

String checkDayMessage() {
  final hoursNow = DateTime.now().hour;
  var messageDay = "";

  if (hoursNow >= 05 && hoursNow <= 10) {
    messageDay = 'Pagi';
  } else if (hoursNow >= 11 && hoursNow <= 14) {
    messageDay = 'Siang';
  } else if (hoursNow >= 15 && hoursNow <= 17) {
    messageDay = 'Sore';
  } else {
    messageDay = 'Malam';
  }
  return messageDay;
}

String formatTimeAgo(String? inputDate) {
  if (inputDate == null) return '-';

  DateTime dateTime = DateFormat("dd-MM-yyyy hh:mm:ss a").parse(inputDate);
  DateTime now = DateTime.now();

  Duration difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return "Baru saja";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes} menit yang lalu";
  } else if (difference.inHours < 24) {
    return "${difference.inHours} jam yang lalu";
  } else if (difference.inDays < 7) {
    return "${difference.inDays} hari yang lalu";
  } else if (difference.inDays < 30) {
    int weeks = (difference.inDays / 7).floor();
    return "$weeks minggu yang lalu";
  } else if (difference.inDays < 365) {
    int months = (difference.inDays / 30).floor();
    return "$months bulan yang lalu";
  } else {
    int years = (difference.inDays / 365).floor();
    return "$years tahun yang lalu";
  }
}

String formatedDateToString({
  String? oldPattern,
  required String newPattern,
  required String? value,
}) {
  if (value == null) return '-';

  DateTime inputDate;

  if (oldPattern != null) {
    final inputFormat = DateFormat(oldPattern);
    inputDate = inputFormat.parse(value);
  } else {
    inputDate = DateTime.parse(value);
  }

  final outputFormat = DateFormat(newPattern, 'id_ID');
  return outputFormat.format(inputDate);
}

void detailPicture(
  BuildContext context,
  ImageProvider<Object> provider,
) {
  showDialog(
    context: context,
    builder: (context) => Dialog.fullscreen(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          InteractiveViewer(
            clipBehavior: Clip.none,
            maxScale: 5,
            child: Center(child: Image(image: provider)),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
