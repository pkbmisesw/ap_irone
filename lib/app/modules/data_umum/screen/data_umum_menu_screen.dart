import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/app/modules/data_rekap/screen/data_rekap_barchart_screen.dart';
import 'package:silahan_kawan/app/modules/data_rekap/screen/data_rekap_input_screen.dart';
import 'package:silahan_kawan/app/modules/data_rekap/screen/data_rekap_linechart_screen.dart';
import 'package:silahan_kawan/app/modules/data_rekap/screen/data_rekap_piechart_screen.dart';
import 'package:silahan_kawan/app/modules/data_rekap/screen/data_rekap_screen.dart';
import 'package:silahan_kawan/app/modules/data_rekap/screen/data_rekap_table_screen.dart';
import 'package:silahan_kawan/app/modules/home/views/appbar.dart';
import 'package:silahan_kawan/app/utils/local_db.dart';
import 'package:silahan_kawan/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_umum_bar_chart_screen.dart';
import 'data_umum_input_screen.dart';
import 'data_umum_line_chart_screen.dart';
import 'data_umum_list_screen.dart';
import 'data_umum_pie_chart_screen.dart';
import 'data_umum_table_screen.dart';

class DataUmumMenuScreen extends StatefulWidget {
  DataUmumMenuScreen({super.key});

  @override
  State<DataUmumMenuScreen> createState() => _DataUmumMenuScreenState();
}

class _DataUmumMenuScreenState extends State<DataUmumMenuScreen> {
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
        backgroundColor: Color(0xffF4F7F7),
        appBar: AppBarUniversal(title: 'Data Menu - admin : ${_loadName()}'),
        body: Padding(
          padding: const EdgeInsets.all(29),
          child: Column(
            children: [
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.83,
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 25,
                      crossAxisCount: 2),
                  shrinkWrap: true,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => DataUmumInputScreen());
                      },
                      child: ButtonData(
                        image: 'assets/img/input.png',
                        title: 'Input Data',
                        data: 'Untuk melakukan input data',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => DataUmumListScreen());
                      },
                      child: ButtonData(
                        image: 'assets/img/list.png',
                        title: 'List Data',
                        data: 'Melihat data dalam bentuk list',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => TableDataUmumScreen());
                      },
                      child: ButtonData(
                        image: 'assets/img/table.png',
                        title: 'Table Chart',
                        data: 'Melihat data dalam bentuk table',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => DataUmumPieScreen());
                      },
                      child: ButtonData(
                        image: 'assets/img/pie.png',
                        title: 'Pie Chart',
                        data: 'Tampilan Grafik dalam Pie Chart',
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Get.to(() => DataRekapDataUmumBarScreen());
                    //   },
                    //   child: ButtonData(
                    //     image: 'assets/img/bar.png',
                    //     title: 'Bar Chart',
                    //     data: 'Tampilan Grafik dalam Bar Chart',
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     Get.to(() => DataUmumLineScreen());
                    //   },
                    //   child: ButtonData(
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
      padding: EdgeInsets.all(21),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        shadows: [
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
          SizedBox(
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
          SizedBox(
            height: 2,
          ),
          Text(
            data,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Color.fromARGB(255, 104, 102, 102),
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
