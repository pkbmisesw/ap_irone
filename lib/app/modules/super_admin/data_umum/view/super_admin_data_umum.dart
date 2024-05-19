import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../widget/super_admin_list_card.dart';
import 'super_admin_data_list.dart';
import 'super_admin_data_piechart.dart';
import 'super_admin_data_umum_table.dart';

class SuperAdminDataUmum extends StatelessWidget {
  const SuperAdminDataUmum({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperAdminListCard(
        fuctionList: () {
          Get.to(() => SuperDataUmumListScreen());
        },
        fuctionTable: () {
          Get.to(() => SuperAdminTableDataUmumScreen());
        },
        fuctionPie: () {
          Get.to(() => MenuUmumPieList());
        },
        title: 'Data Umum Menu');
  }
}
