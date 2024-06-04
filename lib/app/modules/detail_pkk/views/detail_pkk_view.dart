import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:silahan_kawan/app/modules/home/views/appbar.dart';
import 'package:silahan_kawan/app/modules/home/widget/button_list.dart';
import 'package:silahan_kawan/app/widgets/loader.dart';
import 'package:silahan_kawan/theme.dart';
import '../controllers/detail_pkk_controller.dart';
import '../services/detail_pkk_services.dart';

final pkkDummy = {
  "Catatan data & kegiatan warga":
      "https://tppkk-bitung.com/images/imageCatatan.jpg",
  "Data Umum": "https://tppkk-bitung.com/images/imageCatatan.jpg",
  "Pokja I": "https://tppkk-bitung.com/images/imageCatatan.jpg",
  "Pokja II": "https://tppkk-bitung.com/images/imageCatatan.jpg",
  "Pokja III": "https://tppkk-bitung.com/images/imageCatatan.jpg",
  "Pokja IV": "https://tppkk-bitung.com/images/imageCatatan.jpg",
};

class DetailPkkView extends GetView<DetailPkkController> {
  DetailPkkView({Key? key}) : super(key: key);
  final RxBool isLoading = false.obs;

  String getValueImage(String key) {
    if (key == 'Catatan data & kegiatan warga') {
      return 'catatan-data';
    } else if (key == 'Data Umum') {
      return 'data-umum';
    } else if (key == 'Pokja I') {
      return 'data-pokjaa';
    } else if (key == 'Pokja II') {
      return 'data-pokjab';
    } else if (key == 'Pokja III') {
      return 'data-pokjac';
    } else if (key == 'Pokja IV') {
      return 'data-pokjad';
    } else {
      return '';
    }
  }

  String imageData(String key) {
    if (key == 'Catatan data & kegiatan warga') {
      return 'assets/ic/drekap.png';
    } else if (key == 'Data Umum') {
      return 'assets/ic/dumum.png';
    } else if (key == 'Pokja I') {
      return 'assets/ic/pokja1.png';
    } else if (key == 'Pokja II') {
      return 'assets/ic/pokja2.png';
    } else if (key == 'Pokja III') {
      return 'assets/ic/pokja3.png';
    } else if (key == 'Pokja IV') {
      return 'assets/ic/pokja4.png';
    } else {
      return 'assets/ic/setting.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUniversal(
        title: 'Data PKK',
        color: trueBlack,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: List.generate(
                pkkDummy.length,
                (index) => Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        child: UnExpandableRecords(
                          data: SettingData(
                              image: imageData(pkkDummy.keys.elementAt(index)),
                              title: pkkDummy.keys.elementAt(index),
                              onTap: () async {
                                isLoading.value = true;
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog.fullscreen(
                                    backgroundColor: Colors.transparent,
                                    child: Obx(() => isLoading.value
                                        ? Loader()
                                        : SizedBox()),
                                  ),
                                );

                                final image = await DetailPkkServices()
                                    .getImage(getValueImage(
                                        pkkDummy.keys.elementAt(index)));

                                if (image != '') {
                                  Get.back();
                                  isLoading.value = false;
                                  detailPictureWithLoading(
                                    context,
                                    CachedNetworkImageProvider(
                                        'https://tppkk-bitung.com/images/$image'),
                                  );
                                } else {
                                  isLoading.value = true;
                                }
                                print(image);
                              },
                              children: []),
                        ),
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}

void detailPictureWithLoading(
    BuildContext context, ImageProvider<Object> provider) {
  showDialog(
    context: context,
    builder: (context) => Dialog.fullscreen(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          InteractiveViewer(
            clipBehavior: Clip.none,
            maxScale: 5,
            child: Center(child: Image(image: provider)),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
