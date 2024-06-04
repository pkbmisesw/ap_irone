import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:silahan_kawan/app/data/models/letter/item_letter_model.dart';
import 'package:silahan_kawan/app/shared/shared_method.dart';
import 'package:silahan_kawan/theme.dart';
import 'package:remixicon/remixicon.dart';

import '../controllers/letter_controller.dart';

class LetterView extends StatefulWidget {
  @override
  _LetterViewState createState() => _LetterViewState();
}

class _LetterViewState extends State<LetterView> {
  final controller = Get.find<LetterController>();

  late ScrollController scrollController;
  int loadedImageCount = 10;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoading) {
        loadMoreImages();
      }
    });
  }

  Future<void> loadMoreImages() async {
    isLoading = true;
    setState(() {});
    print('jalan');

    // Delay untuk simulasi proses pengambilan data
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      loadedImageCount += 10;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    Widget builderItemArticle(ItemLetterModel data) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.only(left: 10),
          decoration: ShapeDecoration(
            color: bgRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Container(
            color: bgWhite,
            child: ListTile(
              key: ValueKey(data.id),
              title: Text(
                data.nama ?? '-',
                style: GoogleFonts.poppins(
                    color: basicBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              titleTextStyle: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
              subtitle: Text(
                formatedDateToString(
                  oldPattern: 'dd-MM-yyyy',
                  newPattern: DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
                  value: data.tgl,
                ),
                style: GoogleFonts.poppins(
                    color: bgGrey, fontSize: 12, fontWeight: FontWeight.w500),
              ),
              trailing: Image.asset(
                (data.url != null && data.url!.isNotEmpty)
                    ? 'assets/ic/ic_file_pdf.png'
                    : 'assets/ic/ic_file_not_found.png',
                width: size.width * 0.08,
              ),
              onTap: () {
                if (data.url != null && data.url!.isNotEmpty) {
                  controller.moveToDetailLetter(
                    id: data.id.toString(),
                    urlPDF: data.url!,
                  );
                } else {
                  showSnackbar(
                    message: 'File tidak ditemukan',
                    bgColor: theme.colorScheme.error,
                  );
                }
              },
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: bgWhite,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Remix.arrow_left_line,
            color: trueBlack,
          ),
        ),
        title: Obx(
          () => controller.isSearchMode.value
              ? TextField(
                  controller: controller.textController,
                  onChanged: (value) {
                    controller.onSearching();
                  },
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                  style: TextStyle(color: Colors.black),
                )
              : Text('Surat ${controller.typeLetter == 1 ? 'Masuk' : 'Keluar'}',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: trueBlack,
                  )),
        ),
        actions: [
          IconButton(
            icon: Obx(
              () => Icon(
                controller.isSearchMode.value ? Icons.close : Icons.search,
                color: trueBlack,
              ),
            ),
            onPressed: () {
              controller.isSearchMode.toggle();
              if (!controller.isSearchMode.value) {
                controller.textController.clear();
              }
              controller.valueSearch.value = '';
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(() => controller.dataFilter.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(),
                    controller: loadedImageCount < controller.dataFilter.length
                        ? scrollController
                        : null, // Nonaktifkan scroll jika semua gambar telah ditampilkan
                    itemCount: controller.dataFilter.length == 2
                        ? 2
                        : controller.textController.text != ''
                            ? controller.dataFilter.length
                            : loadedImageCount,
                    itemBuilder: (context, index) {
                      final data = controller.dataFilter[index];
                      if (index == controller.dataFilter.length - 1 &&
                          loadedImageCount < controller.dataFilter.length) {
                        return Column(
                          children: [
                            isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: loadMoreImages,
                                    child: Text(
                                      'Load More',
                                    ),
                                  ),
                          ],
                        );
                      } else if (index < controller.dataFilter.length) {
                        // Menampilkan gambar
                        return builderItemArticle(data);
                      } else {
                        // Placeholder untuk menunjukkan bahwa gambar telah habis
                        return SizedBox();
                      }
                    },
                  ),
                )
              : SizedBox()),
          isLoading ? CircularProgressIndicator() : SizedBox(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
