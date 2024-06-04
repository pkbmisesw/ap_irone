import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/widgets/pokja_menu_widget.dart';

import 'data_pokjab_barchart_screen.dart';
import 'data_pokjab_linechart_screen.dart';
import 'data_pokjab_list_screen.dart';
import 'data_pokjab_piechart_screen.dart';
import 'data_pokjab_table_screen.dart';

class AdminKecDataPokjabMenuScreen extends StatelessWidget {
  const AdminKecDataPokjabMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PokjaMenuWidget(
        isInputOn: true,
        fuctionBar: () {
          Get.to(() => AdminKecDataPokjabBarScreen());
        },
        fuctionInput: () {},
        fuctionLine: () {
          Get.to(() => AdminKecDataPokjabLineScreen());
        },
        fuctionList: () {
          Get.to(() => AdminKecDataPokjabListScreen());
        },
        fuctionPie: () {
          Get.to(() => AdminKecDataPokjabPieScreen());
        },
        fuctionTable: () {
          Get.to(() => AdminKecTableDataPokjabScreen());
        },
        title: 'Data Menu Pokja 2');
  }
}
