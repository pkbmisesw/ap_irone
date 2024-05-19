// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irone/app/modules/data_pokjaa/models/data_pokja_model.dart';
import 'package:irone/app/modules/data_rekap/models/data_rekap_models.dart';
import 'package:irone/app/modules/data_rekap/widget/sizedbox_extension.dart';
import '../controllers/data_rekap_controller.dart';

class AdminKecDataRekapScreenNew extends StatefulWidget {
  AdminKecDataRekapScreenNew({super.key, required this.data});

  final DataRekapModels data;

  @override
  State<AdminKecDataRekapScreenNew> createState() =>
      _AdminKecDataRekapScreenNewState();
}

class _AdminKecDataRekapScreenNewState
    extends State<AdminKecDataRekapScreenNew> {
  final controller = Get.put(AdminKecDataRekapServices());

  @override
  void initState() {
    controller.updateEditingControllers(widget.data);
    super.initState();
  }

  bool isLoading = false;

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
          'Data Rekap - ${widget.data.namaLing}',
          style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500, color: Color(0xffB00020)),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: ListView(
                      children: [30.heightBox, _StepperReview()],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _StepperReview extends StatelessWidget {
  _StepperReview({super.key});

  final controller = Get.find<AdminKecDataRekapServices>();

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
