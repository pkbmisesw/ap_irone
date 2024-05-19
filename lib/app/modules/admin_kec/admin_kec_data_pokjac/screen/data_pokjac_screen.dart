import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irone/app/widgets/pokja_menu_widget.dart';

import 'data_pokjac_barchart_screen.dart';
import 'data_pokjac_linechart_screen.dart';
import 'data_pokjac_list_screen.dart';
import 'data_pokjac_piechart_screen.dart';
import 'data_pokjac_table_screen.dart';

class AdminKecDataPokjacScreen extends StatelessWidget {
  const AdminKecDataPokjacScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PokjaMenuWidget(
        fuctionBar: () {
          Get.to(() => AdminKecDataPokjacBarScreen());
        },
        fuctionInput: () {},
        isInputOn: true,
        fuctionLine: () {
          Get.to(() => AdminKecDataPokjacLineScreen());
        },
        fuctionList: () {
          Get.to(() => const AdminKecDataPokjacListScreen());
        },
        fuctionPie: () {
          Get.to(() => AdminKecDataPokjacPieScreen());
        },
        fuctionTable: () {
          Get.to(() => const AdminKecTableDataPokjacScreen());
        },
        title: 'Data Menu Pokja 3');
  }
}
