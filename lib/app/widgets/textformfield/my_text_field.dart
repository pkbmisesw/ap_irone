import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';

class RegistScreen extends StatefulWidget {
  const RegistScreen({super.key});

  @override
  State<RegistScreen> createState() => _RegistScreenState();
}

class _RegistScreenState extends State<RegistScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: Color(0xff44564a),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/bg.png',
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/iconRegis.png',
                      width: 300,
                      height: 160,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "REGISTER",
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _BodyField(
                            controller: emailController,
                            fuction: () {},
                            hint: 'Masukkan nama anda',
                            title: 'Name',
                            icon: Remix.user_2_line,
                          ),
                          _BodyField(
                            controller: emailController,
                            fuction: () {},
                            hint: 'Masukkan email anda',
                            title: 'Email',
                            icon: Remix.mail_line,
                          ),
                          _BodyField(
                            controller: emailController,
                            fuction: () {},
                            hint: 'Masukkan nomor anda',
                            title: 'Number',
                            icon: Remix.phone_line,
                          ),
                          _BodyField(
                            controller: emailController,
                            fuction: () {},
                            hint: '**************"',
                            title: 'Password',
                            icon: Remix.lock_password_line,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const MyButton(
                            onPressed: null,
                            buttonText: 'REGISTER',
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                            child: Row(
                              children: [
                                Text("Belum punya akun?",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: const Color(0xff8d8d8d),
                                    )),
                                TextButton(
                                    child: Text(
                                      "Daftar",
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: const Color(0xff44564a),
                                      ),
                                    ),
                                    onPressed: () {}),
                              ],
                            ),
                          ),
                        ],
                      ),
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

class _BodyField extends StatelessWidget {
  const _BodyField(
      {super.key,
      required this.controller,
      required this.fuction,
      required this.hint,
      required this.title,
      required this.icon});
  final String title;
  final String hint;
  final VoidCallback fuction;
  final TextEditingController controller;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTextField(
          onChanged: (value) {},
          onChangedd: fuction,
          controller: controller,
          hintText: hint,
          obscureText: false,
          prefixIcon: Icon(icon),
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
  const MyButton(
      {super.key, required this.onPressed, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Container(
          height: 55,
          width: 275,
          decoration: const BoxDecoration(
            color: Color(0xff0B6EFE),
          ),
          child: Center(
            child: Text(
              buttonText,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                color: Colors.white,
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
  final Icon prefixIcon;
  final Function()? onChangedd;
  final Function(String) onChanged;
  final bool isObscure;
  final String? value;
  final List<TextInputFormatter>? inputFormatters;
  final bool isDisable;

  const MyTextField(
      {super.key,
      this.value,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.prefixIcon,
      required this.onChanged,
      this.onChangedd,
      this.isObscure = false,
      this.inputFormatters,
      this.isDisable = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          enabled: isDisable,
          hintText: hintText,
          contentPadding: const EdgeInsets.all(10),
          hintStyle: GoogleFonts.poppins(
            fontSize: 15,
            color: const Color(0xff8d8d8d),
          ),
          border: const OutlineInputBorder(),
          prefixIcon: prefixIcon,
          prefixIconColor: const Color(0xffB00020),
          filled: false,
        ),
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}
