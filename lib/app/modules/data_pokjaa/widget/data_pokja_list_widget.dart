import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/app/modules/data_rekap/widget/bottomsheet.dart';
import 'package:silahan_kawan/theme.dart';
import 'package:remixicon/remixicon.dart';

class DataPokjaListWidget extends StatelessWidget {
  DataPokjaListWidget(
      {super.key,
      required this.fuctionMore,
      required this.id,
      required this.idKec,
      required this.idKel,
      required this.ket,
      required this.namaLing,
      this.useName = false});
  final String id;
  final String idKec;
  final String idKel;
  final String namaLing;
  final String ket;
  final bool useName;
  VoidCallback fuctionMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: EdgeInsets.only(left: 6),
        decoration: ShapeDecoration(
          color: bgRed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
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
        child: Container(
          color: bgWhite,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _bodyValue(useName ? 'Kecamatan' : 'Nama Kecamatan', idKec),
                    _bodyValue(useName ? 'Kelurahan' : 'Nama Kelurahan', idKel),
                    _bodyValue('Nama Lingkungan', namaLing),
                    Divider(),
                    RichText(
                      text: TextSpan(
                        text: 'Keterangan :   ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: basicBlack),
                        children: <TextSpan>[
                          TextSpan(
                            text: ket,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: basicBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: fuctionMore,
                  child: Icon(
                    Remix.more_2_fill,
                    color: bgRed,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bodyValue(
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 1,
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: basicBlack,
                  ),
                ))),
        Flexible(
            flex: 1,
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  ': $value',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: basicBlack,
                  ),
                ))),
      ],
    );
  }
}

class ShowModalBodyListPokja extends StatelessWidget {
  ShowModalBodyListPokja(
      {super.key,
      required this.function1,
      required this.function2,
      this.detailData,
      this.isDeleteAdd = false});
  final void Function() function1;
  final void Function() function2;
  final String? detailData;
  final bool isDeleteAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 12,
          ),
          BottomSheetAction(
            title: detailData ?? 'Edit Data',
            icon: Remix.pencil_line,
            iconColor: bgBlue,
            onTap: () {
              Get.back();
              function1();
            },
          ),
          isDeleteAdd
              ? SizedBox()
              : BottomSheetAction(
                  title: 'Delete Data',
                  icon: Remix.delete_bin_6_line,
                  iconColor: bgRed,
                  onTap: () {
                    Get.back();
                    function2();
                  },
                ),
        ],
      ),
    );
  }
}
