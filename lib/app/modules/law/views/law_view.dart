import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:irone/app/data/models/law/item_law_model.dart';
import 'package:irone/app/modules/law/controllers/law_controller.dart';
import 'package:irone/app/shared/shared_method.dart';
import 'package:irone/app/widgets/errors/card_error_item.dart';
import 'package:irone/app/widgets/result/result_widget.dart';
import 'package:irone/theme.dart';

// class LawView extends GetView<LawController> {
//   const LawView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final theme = Theme.of(context);

//     Widget builderListLaw(List<ItemLawModel> data) {
//       return ListView.separated(
//         itemCount: data.length,
//         itemBuilder: (context, index) {
//           final itemData = data[index];

//           return ListTile(
//             key: ValueKey(itemData.id),
//             title: Text(itemData.nama ?? '-'),
//             titleTextStyle: theme.textTheme.titleMedium
//                 ?.copyWith(fontWeight: FontWeight.bold),
//             subtitle: Text(
//               formatedDateToString(
//                 oldPattern: 'dd-MM-yyyy',
//                 newPattern: DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
//                 value: itemData.tgl,
//               ),
//             ),
//             trailing: Image.asset(
//               (itemData.url != null && itemData.url!.isNotEmpty)
//                   ? 'assets/ic/ic_file_pdf.png'
//                   : 'assets/ic/ic_file_not_found.png',
//               width: size.width * 0.08,
//             ),
//             onTap: () {
//               if (itemData.url != null && itemData.url!.isNotEmpty) {
//                 controller.moveToDetailLaw(
//                   id: itemData.id.toString(),
//                   urlPDF: itemData.url!,
//                 );
//               } else {
//                 showSnackbar(
//                   message: 'File tidak ditemukan',
//                   bgColor: theme.colorScheme.error,
//                 );
//               }
//             },
//           );
//         },
//         separatorBuilder: (context, index) => const Divider(),
//       );
//     }

//     Widget builderFutureLaw() {
//       return FutureBuilder(
//         future: controller.getLaw(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData && snapshot.data != null) {
//             if (snapshot.data!.isNotEmpty) {
//               return builderListLaw(snapshot.data!);
//             } else {
//               return ResultWidget.empty(
//                 message: 'Data hukum kosong',
//                 height: size.height * 0.3,
//               );
//             }
//           } else if (snapshot.hasError) {
//             return Center(
//               child: SizedBox(
//                 height: size.height / 4,
//                 child: CardErrorItem(
//                   onPressed: () => controller.getLaw(),
//                 ),
//               ),
//             );
//           }

//           return ResultWidget.loading();
//         },
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hukum'),
//         backgroundColor: bgWhite,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () => Get.back(),
//           icon: const Icon(Icons.arrow_back_ios_new_rounded),
//         ),
//       ),
//       body: builderFutureLaw(),
//     );
//   }
// }
