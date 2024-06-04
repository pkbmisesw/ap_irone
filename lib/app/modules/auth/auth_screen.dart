import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:silahan_kawan/app/modules/auth/login/views/login_view.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:silahan_kawan/app/modules/data_rekap/widget/sizedbox_extension.dart';
import 'package:silahan_kawan/app/widgets/button%20copy.dart';
// import 'package:silahan_kawan/routes/app_pages.dart';
import 'package:silahan_kawan/theme.dart';
// import 'package:silahan_kawan/widget/button%20copy.dart';
// import 'package:silahan_kawan/widget/sizedbox_extension.dart';
import 'package:get/get.dart';

class AuthView extends StatelessWidget {
  AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    // TextScaler textScaleFactor = MediaQuery.of(context).textScaler;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgWhite,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    Image.asset('assets/logo/logoPng.png',
                        height: 114,
                        width: MediaQuery.of(context).size.width / 1.6),
                    SizedBox(height: 31),
                    Text(
                      'Welcome To',
                      style: TextStyle(
                          fontSize: 24,
                          color: bgBlue,
                          fontWeight: Config.semiBold),
                    ),
                    Text(
                      'Silahan Kawan',
                      style: TextStyle(
                          fontSize: 24,
                          color: bgBlue,
                          fontWeight: Config.semiBold),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Create an account and access apps \n that make ur live more easy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          color: trueBlack,
                          fontWeight: Config.medium),
                    ),
                    SizedBox(height: 60),
                    ButtonBaseFull(
                      shadowOn: false,
                      function: () {
                        // Get.toNamed(Routes.REGISTER);
                        Get.to(() => LoginView());
                      },
                      title: 'Get Started',
                    ),
                    SizedBox(height: 20),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black, // Warna teks default
                        ),
                        children: [
                          TextSpan(
                            text: 'Do you have an account ? ',
                          ),
                          TextSpan(
                            text: 'Log In',
                            style: TextStyle(
                                color: bgBlue,
                                decoration: TextDecoration.underline,
                                fontWeight: Config.semiBold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.toNamed(Routes.LOGIN);
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 120),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.black, // Warna teks default
                        ),
                        children: [
                          TextSpan(
                            text: 'By login or register, you agree to our ',
                          ),
                          TextSpan(
                            text: 'Terms and Conditions',
                            style: TextStyle(
                                color: bgBlue,
                                decoration: TextDecoration.underline,
                                fontWeight: Config.semiBold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(() => WebviewPage(
                                //       title: 'Term and Conditions',
                                //       url:
                                //           'https://happs.co.id/terms-conditions.html',
                                //     ));
                              },
                          ),
                          TextSpan(
                            text: ' & ',
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: bgBlue,
                              fontWeight: Config.semiBold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Get.to(() => WebviewPage(
                                //       title: 'Privacy Policy',
                                //       url:
                                //           'https://happs.co.id/privacy-policy.html',
                                //     ));
                              },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
