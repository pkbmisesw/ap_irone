// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/app/modules/data_rekap/widget/sizedbox_extension.dart';
import 'package:silahan_kawan/app/modules/data_rekap/widget/stepper.dart';
import 'package:remixicon/remixicon.dart';

import 'package:silahan_kawan/app/widgets/textformfield/my_text_field.dart';

import '../controllers/data_rekap_input_controller.dart';

class InputDataViewScreen extends StatefulWidget {
  const InputDataViewScreen({super.key});

  @override
  State<InputDataViewScreen> createState() => _InputDataViewScreenState();
}

class _InputDataViewScreenState extends State<InputDataViewScreen> {
  final controller = Get.put(DataRekapInputController());
  bool isLoading = false;
  @override
  void dispose() {
    Get.delete<DataRekapInputController>();
    super.dispose();
  }

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
          'Form Input Data',
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
                    finishTittle: 'Keluarga',
                    phaseState: controller.stepperValue.value,
                    secondTittle: 'Kesejahteraan',
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
                                          controller.inputData(context);
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
  final controller = Get.find<DataRekapInputController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WidgetForm(
          hint: controller.idKec.toString(),
          value: controller.idKec.toString(),
          tittle: 'ID Kecamatan',
          isDisable: false,
          controller: controller.editingControllers[0],
          errorText: '',
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          icon: Remix.profile_line,
        ),
        WidgetForm(
          hint: controller.idKec.toString(),
          value: controller.idKec.toString(),
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
        // ... Dan seterusnya sesuai dengan urutan data dalam list `datas`
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

  final controller = Get.find<DataRekapInputController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        controller.datas.length - 30, // Hanya indeks 20 sampai 44 ini kn 24 14
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

  final controller = Get.find<DataRekapInputController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        controller.datas.length - 20, // Hanya indeks 20 sampai 44 ini kn 24 14
        (index) => WidgetForm(
          hint: 'Masukkan ${controller.datas[index + 20]}',
          tittle: controller.datas[index + 20],
          controller: controller.editingControllers[index + 20],
          errorText: '',
          icon: Remix.pencil_line,
        ),
      ),
    );
  }
}

class _StepperReview extends StatelessWidget {
  _StepperReview({super.key});

  final controller = Get.find<DataRekapInputController>();

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

class WidgetForm extends StatelessWidget {
  const WidgetForm(
      {super.key,
      this.value,
      required this.hint,
      required this.tittle,
      required this.controller,
      this.inputFormatters,
      required this.errorText,
      required this.icon,
      this.readOnly = false,
      this.isDisable = true});
  final String? value;
  final String hint;
  final String tittle;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final String errorText;
  final IconData icon;
  final bool readOnly;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tittle,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF14142B),
          ),
        ),
        const SizedBox(height: 8),
        MyTextField(
          onChanged: (value) {},
          controller: controller,
          hintText: hint,
          obscureText: false,
          inputFormatters: inputFormatters,
          isDisable: isDisable,
          prefixIcon: Icon(
            icon,
            color: Color(0xffB00020),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
