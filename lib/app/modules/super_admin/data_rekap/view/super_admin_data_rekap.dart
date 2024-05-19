import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:irone/app/modules/super_admin/data_rekap/view/super_admin_data_rekap_piechart.dart';

import '../../widget/super_admin_list_card.dart';
import 'super_admin_data_rekap_list.dart';
import 'super_admin_data_rekap_table_screen.dart';

class SuperAdminDataRekap extends StatelessWidget {
  const SuperAdminDataRekap({super.key});

  @override
  Widget build(BuildContext context) {
    return SuperAdminListCard(
        fuctionList: () {
          Get.to(() => SuperDataRekapListScreen());
        },
        fuctionTable: () {
          Get.to(() => SuperAdminTableDataRekapScreen());
        },
        fuctionPie: () {
          Get.to(() => MenuRekapPieList());
        },
        title: 'Data Rekap Menu');
  }
}
