import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../widget/super_admin_list_card.dart';
import 'super_admin_data_pokjad_piechart.dart';
import 'super_admin_data_pokjad_list.dart';
import 'super_admin_data_pokjad_table_screen.dart';

class SuperAdminDataPokjad extends StatelessWidget {
  const SuperAdminDataPokjad({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperAdminListCard(
        fuctionList: () {
          Get.to(() => SuperDataPokjadListScreen());
        },
        fuctionTable: () {
          Get.to(() => SuperAdminTableDataPokjadScreen());
        },
        fuctionPie: () {
          Get.to(() => MenuPokjadPieList());
        },
        title: 'Data Pokja 4 Menu');
  }
}
