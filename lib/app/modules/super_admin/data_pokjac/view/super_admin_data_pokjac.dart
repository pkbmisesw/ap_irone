import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../widget/super_admin_list_card.dart';
import 'super_admin_data_pokjac_list.dart';
import 'super_admin_data_pokjac_piechart.dart';
import 'super_admin_data_pokjac_table_screen.dart';

class SuperAdminDataPokjac extends StatelessWidget {
  const SuperAdminDataPokjac({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperAdminListCard(
        fuctionList: () {
          Get.to(() => SuperDataPokjacListScreen());
        },
        fuctionTable: () {
          Get.to(() => SuperAdminTableDataPokjacScreen());
        },
        fuctionPie: () {
          Get.to(() => MenuPokjacPieList());
        },
        title: 'Data Pokja 3 Menu');
  }
}
