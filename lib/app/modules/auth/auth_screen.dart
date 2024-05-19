import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irone/app/modules/auth/login/views/login_screen.dart';
import 'package:irone/app/routes/app_pages.dart';
import 'package:irone/theme.dart';
import 'register/views/signup_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'Powered by : ',
                  //       style: GoogleFonts.poppins(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w500,
                  //         color: Colors.black87,
                  //       ),
                  //     ),
                  //     Image.asset(
                  //       'assets/img/logo.png',
                  //       height: 22,
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 17,
                  ),
                  Image.asset(
                    'assets/img/storySet.jpg',
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                  ),
                  Text(
                    'Selamat Datang',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Selamat datang di Iron Smartdik',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3b444b).withOpacity(0.7),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyButton(
                    bgColor: bgRed,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    buttonText: 'LOGIN',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyButton(
                    bgColor: Colors.white,
                    onPressed: () {
                      Get.toNamed(Routes.REGISTER);
                    },
                    borderColor: bgRed,
                    buttonText: 'REGISTER',
                    textColor: bgRed,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
