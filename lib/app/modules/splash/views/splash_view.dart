import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/img/logo.png',
                  width: size.width / 2.5,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Lottie.asset(
                  'assets/anim/anim_loading.json',
                  height: size.height / 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
