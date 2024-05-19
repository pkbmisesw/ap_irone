import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:irone/app/utils/constants_lottie.dart';

abstract class ResultWidget {
  static final _size = Get.size;

  static Widget loadingShimmer({required Widget child}) {
    return child.animate(onPlay: (controller) => controller.repeat()).shimmer(
          duration: 1800.ms,
          color: Get.theme.colorScheme.onSurface.withOpacity(0.2),
        );
  }

  static Widget loading({
    String asset = ConstantsLottie.loading,
    String message = 'Loading...',
    double? width,
    double? height,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LottieBuilder.asset(
            asset,
            width: width,
            height: height ?? _size.height * 0.15,
          ),
          Text(
            message,
            style: Get.theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static Widget empty({
    // String asset = ConstantsLottie.empty,
    String message = 'Data tidak ditemukan',
    double? width,
    double? height,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // LottieBuilder.asset(
            //   asset,
            //   width: width,
            //   height: height,
            //   repeat: false,
            // ),
            Text(
              message,
              style: Get.theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
