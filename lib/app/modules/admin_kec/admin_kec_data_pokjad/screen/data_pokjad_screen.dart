import 'package:flutter/material.dart';
import 'package:silahan_kawan/app/widgets/pokja_menu_widget.dart';
import 'package:get/get.dart';
import 'data_pokjad_barchart_screen.dart';
import 'data_pokjad_linechart_screen.dart';
import 'data_pokjad_list_screen.dart';
import 'data_pokjad_piechart_screen.dart';
import 'data_pokjad_table_screen.dart';

class AdminKecDataPokjadScreen extends StatelessWidget {
  const AdminKecDataPokjadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PokjaMenuWidget(
        isInputOn: true,
        fuctionBar: () {
          Get.to(() => AdminKecDataPokjadBarScreen());
        },
        fuctionInput: () {},
        fuctionLine: () {
          Get.to(() => AdminKecDataPokjadLineScreen());
        },
        fuctionList: () {
          Get.to(() => AdminKecDataPokjadListScreen());
        },
        fuctionPie: () {
          Get.to(() => AdminKecDataPokjadPieScreen());
        },
        fuctionTable: () {
          Get.to(() => AdminKecTableDataPokjadScreen());
        },
        title: 'Data Menu Pokja 4');
  }
}
