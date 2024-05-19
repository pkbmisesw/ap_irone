// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irone/app/modules/data_pokjaa/models/data_pokja_model.dart';
import 'package:irone/app/modules/data_rekap/widget/sizedbox_extension.dart';
import '../controller/super_admin_data_pokjaa_controller.dart';

class SuperAdminDataPokjaaViewScreen extends StatefulWidget {
  SuperAdminDataPokjaaViewScreen({super.key, required this.data});

  final DataPokjaModel data;

  @override
  State<SuperAdminDataPokjaaViewScreen> createState() =>
      _SuperAdminDataPokjaaViewScreenState();
}

class _SuperAdminDataPokjaaViewScreenState
    extends State<SuperAdminDataPokjaaViewScreen> {
  final controller = Get.put(SuperAdminDataPokjaaServices());

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
          'Data Pokja 1 - ${widget.data.namaLing}',
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

  final controller = Get.find<SuperAdminDataPokjaaServices>();

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
