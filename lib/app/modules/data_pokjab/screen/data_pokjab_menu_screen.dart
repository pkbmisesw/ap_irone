import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/widgets/pokja_menu_widget.dart';

import 'data_pokjab_barchart_screen.dart';
import 'data_pokjab_input_screen.dart';
import 'data_pokjab_linechart_screen.dart';
import 'data_pokjab_list_screen.dart';
import 'data_pokjab_piechart_screen.dart';
import 'data_pokjab_table_screen.dart';

class DataPokjabMenuScreen extends StatelessWidget {
  const DataPokjabMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PokjaMenuWidget(
        fuctionBar: () {
          Get.to(() => DataPokjabBarScreen());
        },
        fuctionInput: () {
          Get.to(() => DataPokjabInputScreen());
        },
        fuctionLine: () {
          Get.to(() => DataPokjabLineScreen());
        },
        fuctionList: () {
          Get.to(() => DataPokjabListScreen());
        },
        fuctionPie: () {
          Get.to(() => DataPokjabPieScreen());
        },
        fuctionTable: () {
          Get.to(() => TableDataPokjabScreen());
        },
        title: 'Data Menu Pokja 2');
  }
}
