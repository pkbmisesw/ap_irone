import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irone/app/modules/data_rekap/widget/sizedbox_extension.dart';
import 'package:irone/app/modules/home/views/appbar.dart';
import 'package:irone/theme.dart';
import 'package:remixicon/remixicon.dart';

class PokjaMenuWidget extends StatelessWidget {
  PokjaMenuWidget(
      {super.key,
      required this.fuctionBar,
      required this.fuctionInput,
      required this.fuctionLine,
      required this.fuctionList,
      required this.fuctionPie,
      required this.fuctionTable,
      required this.title,
      this.isInputOn = false});
  final VoidCallback fuctionInput;
  final VoidCallback fuctionList;
  final VoidCallback fuctionTable;
  final VoidCallback fuctionPie;
  final VoidCallback fuctionBar;
  final VoidCallback fuctionLine;
  final String title;
  final bool isInputOn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUniversal(title: title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            isInputOn
                ? SizedBox()
                : _WidgetMenu(
                    bgColor: Color(0xffF6D6D6),
                    image: 'assets/img/input.png',
                    subTitle: 'Untuk Melakukan Input Data',
                    title: 'Input Data',
                    fuction: fuctionInput,
                  ),
            _WidgetMenu(
              bgColor: Color(0xffAEE2FF),
              image: 'assets/img/list.png',
              subTitle: 'Melihat data dalam bentuk list',
              title: 'List Data',
              fuction: fuctionList,
            ),
            _WidgetMenu(
              bgColor: Color(0xffadf7b6),
              image: 'assets/img/table.png',
              subTitle: 'Melihat data dalam bentuk table',
              title: 'Table Data',
              fuction: fuctionTable,
            ),
            _WidgetMenu(
              bgColor: Color(0xffD2E0FB),
              image: 'assets/img/pie.png',
              subTitle: 'Tampilan Grafik dalam Pie Chart',
              title: 'Pie Chart',
              fuction: fuctionPie,
            ),
            // _WidgetMenu(
            //   bgColor: Color(0xffF9EFDB),
            //   image: 'assets/img/bar.png',
            //   subTitle: 'Tampilan Grafik dalam Bar Chart',
            //   title: 'Bar Chart',
            //   fuction: fuctionBar,
            // ),
            // _WidgetMenu(
            //   bgColor: Color(0xffCDFCF6),
            //   image: 'assets/img/line.png',
            //   subTitle: 'Tampilan Grafik dalam Line Chart',
            //   title: 'Line Chart',
            //   fuction: fuctionLine,
            // ),
          ]),
        ),
      ),
    );
  }
}

class _WidgetMenu extends StatelessWidget {
  const _WidgetMenu(
      {super.key,
      required this.bgColor,
      required this.image,
      required this.subTitle,
      required this.title,
      required this.fuction});
  final String title;
  final Color bgColor;
  final String subTitle;
  final String image;
  final VoidCallback fuction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: fuction,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Image.asset(
                image,
                height: 50,
              ),
              10.widthBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        color: basicBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: GoogleFonts.poppins(
                        color: basicBlack,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Remix.arrow_right_circle_line,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
