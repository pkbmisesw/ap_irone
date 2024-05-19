import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irone/app/modules/home/views/appbar.dart';
import 'package:irone/app/utils/local_db.dart';
import 'package:irone/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_umum_bar_chart_screen.dart';
import 'data_umum_line_chart_screen.dart';
import 'data_umum_list_screen.dart';
import 'data_umum_pie_chart_screen.dart';
import 'data_umum_table_screen.dart';

class AdminKecDataUmumMenuScreen extends StatefulWidget {
  AdminKecDataUmumMenuScreen({super.key});

  @override
  State<AdminKecDataUmumMenuScreen> createState() =>
      _AdminKecDataUmumMenuScreenState();
}

class _AdminKecDataUmumMenuScreenState
    extends State<AdminKecDataUmumMenuScreen> {
  late SharedPreferences _prefs;
  @override
  void initState() {
    _initPrefs();
    super.initState();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadName();
    setState(() {});
  }

  String _loadName() {
    try {
      final getData = _prefs.getString(LocalDb.keyCredential);

      if (getData != null) {
        return jsonDecode(getData)['users']['nama'];
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF4F7F7),
        appBar: AppBarUniversal(title: 'Data Menu - admin : ${_loadName()}'),
        body: Padding(
          padding: const EdgeInsets.all(29),
          child: Column(
            children: [
              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.83,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 25,
                      crossAxisCount: 2),
                  shrinkWrap: true,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => const AdminKecDataUmumListScreen());
                      },
                      child: const ButtonData(
                        image: 'assets/img/list.png',
                        title: 'List Data',
                        data: 'Melihat data dalam bentuk list',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const AdminKecTableDataUmumScreen());
                      },
                      child: const ButtonData(
                        image: 'assets/img/table.png',
                        title: 'Table Chart',
                        data: 'Melihat data dalam bentuk table',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => AdminKecDataUmumPieScreen());
                      },
                      child: const ButtonData(
                        image: 'assets/img/pie.png',
                        title: 'Pie Chart',
                        data: 'Tampilan Grafik dalam Pie Chart',
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Get.to(() => AdminKecDataUmumBarScreen());
                    //   },
                    //   child: const ButtonData(
                    //     image: 'assets/img/bar.png',
                    //     title: 'Bar Chart',
                    //     data: 'Tampilan Grafik dalam Bar Chart',
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     Get.to(() => AdminKecDataUmumLineScreen());
                    //   },
                    //   child: const ButtonData(
                    //     image: 'assets/img/line.png',
                    //     title: 'Line Chart',
                    //     data: 'Tampilan Grafik dalam Line Chart',
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonData extends StatelessWidget {
  const ButtonData(
      {super.key,
      required this.data,
      required this.image,
      required this.title,
      this.isFullColor = false});
  final String image;
  final String title;
  final String data;
  final bool isFullColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 40,
            width: 40,
          ),
          const SizedBox(
            height: 9,
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: basicBlack,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            data,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color.fromARGB(255, 104, 102, 102),
              fontSize: 10,
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
