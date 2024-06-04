import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:silahan_kawan/app/data/models/law/item_law_model.dart';
import 'package:silahan_kawan/app/modules/data_pokjaa/widget/data_pokja_list_widget.dart';
import 'package:silahan_kawan/app/modules/law/controllers/law_controller.dart';
import 'package:silahan_kawan/app/shared/shared_method.dart';
import 'package:silahan_kawan/theme.dart';
import 'package:remixicon/remixicon.dart';
import 'package:get/get.dart';

class LawView extends StatefulWidget {
  const LawView({super.key});

  @override
  State<LawView> createState() => _LawViewState();
}

class _LawViewState extends State<LawView> {
  final LawController services = LawController();
  final RxList<ItemLawModel> fullData = <ItemLawModel>[].obs;

  final RxList<ItemLawModel> dataFilter = <ItemLawModel>[].obs;

  RxString valueSearch = ''.obs;

  final RxBool isSearchMode = false.obs;
  final TextEditingController textController = TextEditingController();

  void onSearching() {
    valueSearch.value = textController.text.toLowerCase();

    final filteredData = fullData.where((data) {
      final containsSearch = data.nama!.toLowerCase().contains(valueSearch);

      return containsSearch;
    }).toList();

    dataFilter.assignAll(filteredData);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
    services.onInit();
  }

  void fetchData() async {
    try {
      final value = await services.fetchData();
      if (value) {
        fullData.assignAll(services.fullData);
      } else {}
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    services.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
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
            () => isSearchMode.value
                ? TextField(
                    controller: textController,
                    onChanged: (value) {
                      onSearching();
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                  )
                : Text('Hukum',
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
                  isSearchMode.value ? Icons.close : Icons.search,
                  color: trueBlack,
                ),
              ),
              onPressed: () {
                isSearchMode.toggle();
                if (!isSearchMode.value) {
                  textController.clear();
                }
                valueSearch.value = '';
              },
            ),
          ],
        ),
        body: Obx(() => valueSearch.value == ''
            ? ListenableBuilder(
                listenable: services,
                builder: (BuildContext context, Widget? child) => ListView(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  controller: services.scrollDataCTRL,
                  children: [
                    ...List.generate(
                      services.data.length + 1,
                      (index) {
                        if (index < services.data.length) {
                          return widgetBody(
                            value: services.data[index].id ?? 0,
                            nama: services.data[index].nama ?? "",
                            id: services.data[index].id,
                            tanggal: services.data[index].tgl,
                            url: services.data[index].url,
                          );
                        } else if (services.data.isEmpty &&
                            services.hasLimitData) {
                          return const Center(child: Text('Kosong'));
                        } else {
                          return Visibility(
                            visible: services.hasLimitData,
                            replacement: GestureDetector(
                              onTap: services.onStoryReload,
                              child: const Icon(Icons.refresh),
                            ),
                            child: GestureDetector(
                              onTap: services.onStoryReload,
                              child: const Icon(Icons.refresh),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: dataFilter.length,
                itemBuilder: (context, index) {
                  final data = dataFilter[index];
                  return widgetBody(
                      nama: data.nama ?? '',
                      value: data.id ?? 0,
                      id: data.id,
                      tanggal: data.tgl,
                      url: data.url);
                },
              )));
  }

  Widget widgetBody(
      {required int value,
      required String nama,
      String? tanggal,
      String? url,
      int? id}) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
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
          color: bgRed,
          padding: EdgeInsets.only(left: 10),
          child: Container(
            color: bgWhite,
            child: ListTile(
              key: ValueKey(value),
              title: Text(
                nama ?? '-',
                style: GoogleFonts.poppins(
                    color: basicBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              titleTextStyle: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
              subtitle: Text(
                formatedDateToString(
                  oldPattern: 'dd-MM-yyyy',
                  newPattern: DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
                  value: tanggal,
                ),
                style: GoogleFonts.poppins(
                    color: bgGrey, fontSize: 12, fontWeight: FontWeight.w500),
              ),
              trailing: Image.asset(
                (url != null && url!.isNotEmpty)
                    ? 'assets/ic/ic_file_pdf.png'
                    : 'assets/ic/ic_file_not_found.png',
                width: size.width * 0.08,
              ),
              onTap: () {
                if (url != null && url!.isNotEmpty) {
                  services.moveToDetailLaw(
                    id: id.toString(),
                    urlPDF: url!,
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
      ),
    );
  }
}
