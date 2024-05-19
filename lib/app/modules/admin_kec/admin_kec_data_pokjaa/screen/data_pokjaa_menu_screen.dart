import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irone/app/widgets/pokja_menu_widget.dart';

import 'data_pokjaa_barchart_screen.dart';
import 'data_pokjaa_linechart_screen.dart';
import 'data_pokjaa_list_screen.dart';
import 'data_pokjaa_piechart_screen.dart';
import 'data_pokjaa_table_screen.dart';

class AdminKecDataPokjaaMenuScreen extends StatelessWidget {
  const AdminKecDataPokjaaMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PokjaMenuWidget(
        isInputOn: true,
        fuctionBar: () {
          Get.to(() => AdminKecDataPokjaaBarScreen());
        },
        fuctionInput: () {},
        fuctionLine: () {
          Get.to(() => AdminKecDataPokjaaLineScreen());
        },
        fuctionList: () {
          Get.to(() => AdminKecDataPokjaaListScreen());
        },
        fuctionPie: () {
          Get.to(() => AdminKecDataPokjaaPieScreen());
        },
        fuctionTable: () {
          Get.to(() => AdminKecTableDataPokjaaScreen());
        },
        title: 'Data Menu Pokja 1');
  }
}
