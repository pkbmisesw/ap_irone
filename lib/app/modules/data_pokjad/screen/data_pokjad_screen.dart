import 'package:flutter/material.dart';
import 'package:irone/app/widgets/pokja_menu_widget.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'data_pokjad_barchart_screen.dart';
import 'data_pokjad_input_screen.dart';
import 'data_pokjad_linechart_screen.dart';
import 'data_pokjad_list_screen.dart';
import 'data_pokjad_piechart_screen.dart';
import 'data_pokjad_table_screen.dart';

class DataPokjabScreen extends StatelessWidget {
  const DataPokjabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PokjaMenuWidget(
        fuctionBar: () {
          Get.to(() => DataPokjadBarScreen());
        },
        fuctionInput: () {
          Get.to(() => DataPokjadInputScreen());
        },
        fuctionLine: () {
          Get.to(() => DataPokjadLineScreen());
        },
        fuctionList: () {
          Get.to(() => DataPokjadListScreen());
        },
        fuctionPie: () {
          Get.to(() => DataPokjadPieScreen());
        },
        fuctionTable: () {
          Get.to(() => TableDataPokjadScreen());
        },
        title: 'Data Menu Pokja 4');
  }
}
