import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/widgets/pokja_menu_widget.dart';

import 'data_pokjac_barchart_screen.dart';
import 'data_pokjac_input_screen.dart';
import 'data_pokjac_linechart_screen.dart';
import 'data_pokjac_list_screen.dart';
import 'data_pokjac_piechart_screen.dart';
import 'data_pokjac_table_screen.dart';

class DataPokjadScreen extends StatelessWidget {
  const DataPokjadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PokjaMenuWidget(
        fuctionBar: () {
          Get.to(() => DataPokjacBarScreen());
        },
        fuctionInput: () {
          Get.to(() => DataPokjacInputScreen());
        },
        fuctionLine: () {
          Get.to(() => DataPokjacLineScreen());
        },
        fuctionList: () {
          Get.to(() => DataPokjacListScreen());
        },
        fuctionPie: () {
          Get.to(() => DataPokjacPieScreen());
        },
        fuctionTable: () {
          Get.to(() => TableDataPokjacScreen());
        },
        title: 'Data Menu Pokja 3');
  }
}
