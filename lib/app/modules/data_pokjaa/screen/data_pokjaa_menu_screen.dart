import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irone/app/widgets/pokja_menu_widget.dart';

import 'data_pokjaa_barchart_screen.dart';
import 'data_pokjaa_input_screen.dart';
import 'data_pokjaa_linechart_screen.dart';
import 'data_pokjaa_list_screen.dart';
import 'data_pokjaa_piechart_screen.dart';
import 'data_pokjaa_table_screen.dart';

class DataPokjaaMenuScreen extends StatelessWidget {
  const DataPokjaaMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PokjaMenuWidget(
        fuctionBar: () {
          Get.to(() => DataPokjaaBarScreen());
        },
        fuctionInput: () {
          Get.to(() => DataPokjaInputScreen());
        },
        fuctionLine: () {
          Get.to(() => DataPokjaaLineScreen());
        },
        fuctionList: () {
          Get.to(() => DataPokjaaListScreen());
        },
        fuctionPie: () {
          Get.to(() => DataPokjaaPieScreen());
        },
        fuctionTable: () {
          Get.to(() => TableDataPokjaaScreen());
        },
        title: 'Data Menu Pokja 1');
  }
}
