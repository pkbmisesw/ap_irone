import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:irone/app/modules/super_admin/data_pokjaa/view/super_admin_data_pokjaa_piechart.dart';

import '../../widget/super_admin_list_card.dart';
import 'super_admin_data_pokjaa_list.dart';
import 'super_admin_data_pokjaa_table_screen.dart';

class SuperAdminDataPokja extends StatelessWidget {
  const SuperAdminDataPokja({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperAdminListCard(
        fuctionList: () {
          Get.to(() => SuperDataPokjaaListScreen());
        },
        fuctionTable: () {
          Get.to(() => SuperAdminTableDataPokjaScreen());
        },
        fuctionPie: () {
          Get.to(() => MenuPokjaaPieList());
        },
        title: 'Data Pokja 1 Menu');
  }
}
