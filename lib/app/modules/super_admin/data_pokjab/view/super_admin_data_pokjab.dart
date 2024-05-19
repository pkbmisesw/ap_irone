import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../widget/super_admin_list_card.dart';
import 'super_admin_data_pokjab_list.dart';
import 'super_admin_data_pokjab_piechart.dart';
import 'super_admin_data_pokjab_table_screen.dart';

class SuperAdminDataPokjab extends StatelessWidget {
  const SuperAdminDataPokjab({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperAdminListCard(
        fuctionList: () {
          Get.to(() => SuperDataPokjabListScreen());
        },
        fuctionTable: () {
          Get.to(() => SuperAdminTableDataPokjabScreen());
        },
        fuctionPie: () {
          Get.to(() => MenuPokjabPieList());
        },
        title: 'Data Pokja 2 Menu');
  }
}
