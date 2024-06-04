// import 'package:silahan_kawan/module/home/auth/login/view/widget_field.dart';
// import 'package:silahan_kawan/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:silahan_kawan/app/modules/auth/login/controllers/login_controller.dart';
import 'package:silahan_kawan/app/modules/auth/register/views/register_view.dart';
import 'package:silahan_kawan/app/modules/auth/register/views/signup_screen.dart';
import 'package:silahan_kawan/app/modules/data_rekap/widget/sizedbox_extension.dart';
import 'package:silahan_kawan/app/routes/app_pages.dart';
// import 'package:silahan_kawan/module/login/widget_field.dart';
// import 'package:silahan_kawan/module/register/register_view.dart';
import 'package:silahan_kawan/theme.dart';
// import 'package:silahan_kawan/widget/loader.dart';
// import 'package:silahan_kawan/widget/sizedbox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
// import 'package:silahan_kawan/module/login/controller/login_controller.dart';
// import '../controller/login_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _BodyLogin(),
      ),
    );
  }
}

class _BodyLogin extends GetView<LoginController> {
  const _BodyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(
              'assets/img/bg.svg',
              width: 180,
              height: 160,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 10, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Silahan Kawan",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Sign in to continue",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      const Color(0xff3b444b).withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                          Image.asset(
                            'assets/logo/logoPng.png',
                            height: 80,
                            width: 120,
                          )
                        ],
                      ),
                      const SizedBox(
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
                          Row(
                            children: [
                              Obx(
                                () => Transform.scale(
                                  scale: 1.2,
                                  child: SizedBox(
                                    width: 20,
                                    child: Checkbox(
                                        checkColor: bgWhite,
                                        activeColor: bgBlue,
                                        onChanged: (value) {
                                          controller.isRemember.value = value!;
                                        },
                                        value: controller.isRemember.value,
                                        visualDensity: VisualDensity.standard),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text('Remember Me',
                                  style: TextStyle(fontWeight: Config.medium))
                            ],
                          ),
                          SizedBox(height: 20),
                          MyButton(
                            bgColor: bgBlue,
                            onPressed: () {
                              // controller.checkIsUserExist(context);
                              // Get.toNamed(Routes.HOME);
                              // moveToPage();
                              Get.offAllNamed(Routes.MAIN_USER);
                            },
                            buttonText: 'SIGN IN',
                          ),
                          SizedBox(height: 12),
                          SizedBox(height: 10),
                          Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                    color: bgGrey,
                                    fontWeight: Config.reguler,
                                    fontSize: 12),
                                children: [
                                  const TextSpan(
                                    text: 'Already Have an Account ? ',
                                  ),
                                  TextSpan(
                                    text: 'Register',
                                    style: TextStyle(
                                      color: bgBlue,
                                      fontWeight: Config.semiBold,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(() => RegisterView());
                                      },
                                  ),
                                ],
                              ),
                            ),
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
      ],
    );
  }
}
