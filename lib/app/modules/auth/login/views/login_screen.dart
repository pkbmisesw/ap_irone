import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/app/routes/app_pages.dart';
import 'package:silahan_kawan/theme.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../widgets/loader.dart';
import '../controllers/login_controller.dart';
import '../../register/views/signup_screen.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: Color(0xff44564a),
          body: Obx(() => controller.isLoading.value
              ? Stack(
                  children: [_BodyLogin(), Loader()],
                )
              : _BodyLogin())),
    );
  }
}

class _BodyLogin extends GetView<LoginController> {
  const _BodyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 10, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Remix.arrow_left_line,
                color: bgRed,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "HI!",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Sign in to continue",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff3b444b).withOpacity(0.7),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BodyField(
                          controller: controller.emailC,
                          fuction: () {},
                          hint: 'Masukkan email anda',
                          title: 'Email',
                          boolIsNoBorder: true,
                          validator: controller.validatorEmail,
                        ),
                        Obx(
                          () => BodyField(
                            controller: controller.passwordC,
                            validator: controller.validatorPassword,
                            fuction: () {},
                            hint: '**************',
                            title: 'Password',
                            icon: IconButton(
                              onPressed: () => controller.setObscure(),
                              icon: Icon(
                                (controller.isObscure.value)
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                              ),
                            ),
                            boolIsNoBorder: true,
                            isObscure: controller.isObscure.value,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyButton(
                          bgColor: bgRed,
                          onPressed: () {
                            controller.checkIsUserExist(theme);
                          },
                          buttonText: 'SIGN IN',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("Forgot Password?",
                              textAlign: TextAlign.end,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: bgRed,
                              )),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: bgGreyLite,
                                thickness: 2,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('or'),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Divider(
                                color: bgGreyLite,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Belum punya akun?",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff8d8d8d),
                                )),
                            TextButton(
                                child: Text(
                                  "Daftar",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: bgRed,
                                  ),
                                ),
                                onPressed: () => Get.toNamed(Routes.REGISTER)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
