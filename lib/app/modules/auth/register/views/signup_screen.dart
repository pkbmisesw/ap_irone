import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/app/modules/auth/login/views/login_screen.dart';
import 'package:silahan_kawan/app/widgets/loader.dart';
import 'package:silahan_kawan/theme.dart';
import 'package:remixicon/remixicon.dart';

import '../controllers/register_controller.dart';

class RegistScreen extends GetView<RegisterController> {
  const RegistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: Color(0xff44564a),
          body: Obx(() => controller.isLoading.value
              ? Stack(
                  children: [_BodySignup(), Loader()],
                )
              : _BodySignup())),
    );
  }
}

class _BodySignup extends GetView<RegisterController> {
  _BodySignup({super.key});

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
                    "Create a new account",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3b444b).withOpacity(0.7),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BodyField(
                          controller: controller.namaC,
                          validator: controller.validatorNama,
                          fuction: () {},
                          hint: 'Masukkan nama anda',
                          title: 'Name',
                          boolIsNoBorder: true,
                        ),
                        BodyField(
                          controller: controller.emailC,
                          fuction: () {},
                          hint: 'Masukkan email anda',
                          title: 'Email',
                          boolIsNoBorder: true,
                          validator: controller.validatorEmail,
                        ),
                        // BodyField(
                        //   controller: controller.emailC,
                        //   fuction: () {},
                        //   hint: 'Masukkan nomor anda',
                        //   title: 'Number',
                        //   icon: Remix.phone_line,
                        //   boolIsNoBorder: true,
                        //    validator: controller.validatorNama,
                        // ),
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
                            controller.checkRegisterData(theme);
                          },
                          buttonText: 'REGISTER',
                        ),
                        const SizedBox(
                          height: 16,
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
                          height: 12,
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
                            Text("Sudah punya akun?",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff8d8d8d),
                                )),
                            TextButton(
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: bgRed,
                                  ),
                                ),
                                onPressed: () => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                    )),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyField extends StatelessWidget {
  BodyField(
      {super.key,
      required this.controller,
      required this.fuction,
      required this.hint,
      required this.title,
      this.icon,
      this.boolIsNoBorder = false,
      required this.validator,
      this.isObscure = false});
  final String title;
  final String hint;
  final VoidCallback fuction;
  final TextEditingController controller;
  final Widget? icon;
  final bool boolIsNoBorder;
  final String? Function(dynamic value) validator;

  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextField(
          onChanged: fuction,
          controller: controller,
          hintText: hint,
          obscureText: false,
          boolIsNoBorder: boolIsNoBorder,
          prefixIcon: icon,
          validator: validator,
          isObscure: isObscure,
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

class MyButton extends StatelessWidget {
  final Function()? onPressed;
  final String buttonText;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  const MyButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      this.textColor,
      this.borderColor,
      this.bgColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Container(
          height: 45,
          width: 275,
          decoration: BoxDecoration(
              color: bgColor ?? Color(0xff0B6EFE),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: borderColor ?? Colors.transparent, width: 2)),
          child: Center(
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: textColor ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_typing_uninitialized_variables

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  final Function()? onChanged;
  final bool isObscure;
  final List<TextInputFormatter>? inputFormatters;
  final bool boolIsNoBorder;
  final String? Function(dynamic value) validator;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.prefixIcon,
      this.onChanged,
      this.isObscure = false,
      this.inputFormatters,
      this.boolIsNoBorder = false,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
            hintText: hintText,
            enabledBorder:
                boolIsNoBorder ? UnderlineInputBorder() : OutlineInputBorder(),
            contentPadding: EdgeInsets.all(10),
            hintStyle: GoogleFonts.poppins(
              fontSize: 15,
              color: Color(0xff8d8d8d),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: bgBlue),
            ),
            suffixIcon: prefixIcon),
        validator: validator,
      ),
    );
  }
}
