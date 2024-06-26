// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/app/modules/data_pokjaa/controller/data_pokjaa_controller.dart';
import 'package:silahan_kawan/app/modules/data_pokjaa/models/data_pokja_model.dart';
import 'package:silahan_kawan/app/modules/data_rekap/widget/sizedbox_extension.dart';
import 'package:silahan_kawan/app/modules/data_rekap/widget/stepper.dart';
import 'package:remixicon/remixicon.dart';

import '../../data_rekap/screen/data_rekap_input_screen.dart';

class DataPokjaDetailScreen extends StatefulWidget {
  DataPokjaDetailScreen({super.key, required this.data});

  final DataPokjaModel data;

  @override
  State<DataPokjaDetailScreen> createState() => _DataPokjaDetailScreenState();
}

class _DataPokjaDetailScreenState extends State<DataPokjaDetailScreen> {
  final controller = Get.put(DataPokjaaController());
  @override
  void dispose() {
    controller.stepperValue.value = 0;
    controller.updateStepperValue(controller.stepperValue.value);
    super.dispose();
  }

  @override
  void initState() {
    controller.updateEditingControllers(widget.data);
    super.initState();
  }

  bool isLoading = false;

  Widget _buildStepperWidget(int stepperValue) {
    switch (stepperValue) {
      case 0:
        return _StepperUmumValue();
      case 1:
        return _StepperKesejahteraanValue();
      case 2:
        return _StepperKeluarga();
      case 3:
        return _StepperReview();
      // Tambahkan case lain jika diperlukan
      default:
        // Tindakan default jika stepperValue tidak sesuai dengan nilai yang diharapkan
        return _StepperUmumValue(); // atau widget lain sebagai default
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 2,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xffB00020),
          ),
        ),
        title: Text(
          'Data Pokja 1 - ${widget.data.namaLing}',
          style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500, color: Color(0xffB00020)),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                20.heightBox,
                Obx(
                  () => StepperStatus(
                    firstTittle: 'Umum',
                    finishTittle: 'Gotong Royong',
                    phaseState: controller.stepperValue.value,
                    secondTittle: 'Pancasila',
                    extendetTittle: 'Cek',
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: ListView(
                      children: [
                        30.heightBox,
                        Obx(
                          () => _buildStepperWidget(
                              controller.stepperValue.value),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 24, top: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        backgroundColor: Colors.white,
                                      ),
                                      onPressed: () {
                                        if (controller.stepperValue.value ==
                                            0) {
                                          Get.back();
                                        } else if (controller
                                                .stepperValue.value ==
                                            1) {
                                          controller.stepperValue.value = 0;
                                        } else if (controller
                                                .stepperValue.value ==
                                            2) {
                                          controller.stepperValue.value = 1;
                                        } else if (controller
                                                .stepperValue.value ==
                                            3) {
                                          controller.stepperValue.value = 2;
                                        }

                                        controller.updateStepperValue(
                                            controller.stepperValue.value);
                                      },
                                      child: Obx(
                                        () => Text(
                                          controller.stepperBUttonCancel.value,
                                          style: GoogleFonts.outfit(
                                            color: Colors.black,
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffB00020)),
                                  height: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          side: const BorderSide(
                                              width: 1.0,
                                              color: Color(0xffB00020)),
                                        ),
                                        backgroundColor:
                                            const Color(0xffB00020),
                                      ),
                                      onPressed: () async {
                                        if (controller.stepperValue.value ==
                                            0) {
                                          controller.stepperValue.value = 1;
                                        } else if (controller
                                                .stepperValue.value ==
                                            1) {
                                          controller.stepperValue.value = 2;
                                        } else if (controller
                                                .stepperValue.value ==
                                            2) {
                                          // controller.submitData();
                                          controller.stepperValue.value = 3;
                                        } else if (controller
                                                .stepperValue.value ==
                                            3) {
                                          Get.back();
                                        }

                                        controller.updateStepperValue(
                                            controller.stepperValue.value);
                                      },
                                      child: Obx(
                                        () => Text(
                                          controller.stepperButtonText.value,
                                          style: GoogleFonts.outfit(
                                              color: Colors.white),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class _StepperUmumValue extends StatelessWidget {
  _StepperUmumValue({super.key});
  final controller = Get.find<DataPokjaaController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WidgetForm(
          hint: controller.editingControllers[0].text,
          value: controller.editingControllers[0].text,
          tittle: 'ID Kecamatan',
          isDisable: false,
          controller: controller.editingControllers[0],
          errorText: '',
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          icon: Remix.profile_line,
        ),
        WidgetForm(
          hint: controller.editingControllers[1].text,
          value: controller.editingControllers[1].text,
          tittle: 'ID Kelurahan',
          controller: controller.editingControllers[1],
          isDisable: false,
          errorText: '',
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          icon: Remix.article_line,
        ),
        WidgetForm(
          hint: 'Masukkan Nama Lingkungan',
          tittle: 'Nama Lingkungan',
          controller: controller.editingControllers[2],
          errorText: '',
          icon: Remix.pencil_line,
        ),
        WidgetForm(
          hint: 'Masukkan ${controller.datas[3]}',
          tittle: controller.datas[3],
          controller: controller.editingControllers[3],
          errorText: '',
          icon: Remix.pencil_line,
        ),
        WidgetForm(
          hint: 'Masukkan ${controller.datas[4]}',
          tittle: controller.datas[4],
          controller: controller.editingControllers[4],
          errorText: '',
          icon: Remix.pencil_line,
        ),
      ],
    );
  }
}

class _StepperKesejahteraanValue extends StatelessWidget {
  _StepperKesejahteraanValue({super.key});

  final controller = Get.find<DataPokjaaController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        controller.datas.length - 11, // Hanya indeks 20 sampai 44 ini kn 24 14
        (index) => WidgetForm(
          hint: 'Masukkan ${controller.datas[index + 5]}',
          tittle: controller.datas[index + 5],
          controller: controller.editingControllers[index + 5],
          errorText: '',
          icon: Remix.pencil_line,
        ),
      ),
    );
  }
}

class _StepperKeluarga extends StatelessWidget {
  _StepperKeluarga({super.key});

  final controller = Get.find<DataPokjaaController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        controller.datas.length - 16, // Hanya indeks 20 sampai 44 ini kn 24 14
        (index) => WidgetForm(
          hint: 'Masukkan ${controller.datas[index + 16]}',
          tittle: controller.datas[index + 16],
          controller: controller.editingControllers[index + 16],
          errorText: '',
          icon: Remix.pencil_line,
        ),
      ),
    );
  }
}

class _StepperReview extends StatelessWidget {
  _StepperReview({super.key});

  final controller = Get.find<DataPokjaaController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(controller.editingControllers.length, (index) {
        final dataValue = controller.datas[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: Text('$dataValue :')),
                  Text(
                    controller.editingControllers[index].text,
                    // Gaya atau konfigurasi teks sesuai kebutuhan
                  ),
                ],
              ),
              10.heightBox,
              Divider(
                height: 1,
              )
            ],
          ),
        );
      }),
    );
  }
}
