import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/modules/data_rekap/controllers/data_rekap_controller.dart';
import 'package:silahan_kawan/app/modules/data_rekap/models/data_rekap_models.dart';

class DataDetailsRekapScreen extends StatelessWidget {
  DataDetailsRekapScreen({super.key, required this.data});
  final DataRekapModels data;

  final controller = Get.put(DataRekapServices());

  @override
  Widget build(BuildContext context) {
    controller.updateEditingControllers(data);
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Rekap - ${data.namaLing}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => controller.canEdit(!controller.canEdit.value),
          ),
        ],
      ),
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              ...List.generate(
                controller.editingControllers.length,
                (index) {
                  return Obx(
                    () => buildTextFormField(
                      index: index,
                      label: controller.datas[index],
                      readOnly: controller.canEdit.isTrue,
                      controller: controller.editingControllers[index],
                      type: controller.keyboardTypes[index],
                      isLast: index == controller.editingControllers.length - 1,
                      validator: controller.keyboardTypes[index] ==
                              TextInputType.number
                          ? numberRequired
                          : inputRequired,
                    ),
                  );
                },
              ),
              Obx(
                () => Visibility(
                  visible: controller.canEdit.isTrue,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ElevatedButton(
                      onPressed: () => controller.submitData(),
                      child: Center(
                        child: Visibility(
                          visible: controller.loadingBtn.value,
                          replacement: const Text("Simpan data"),
                          child: const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFormField({
    required int index,
    required String label,
    required bool readOnly,
    required TextEditingController controller,
    required TextInputType type,
    required bool isLast,
    required String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        readOnly: readOnly,
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        decoration: InputDecoration(
            labelText: label,
            hintText: "Silahkan Mengisi $label",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Theme.of(Get.context!).colorScheme.primary,
                ))),
        controller: controller,
        enabled: !(index == 0 && controller.text.isNotEmpty),
        validator: [0, 1].contains(index) ? validator : null,
        keyboardType: type,
      ),
    );
  }

  String? inputRequired(String? value) {
    if (value == null) {
      return 'Wajib diisi';
    } else if (value.isEmpty) {
      return 'Tidak boleh kosong';
    } else {
      return null;
    }
  }

  String? numberRequired(String? value) {
    final numeric = RegExp(r'\d+');
    if (value == null) {
      return 'Wajib diisi';
    } else if (value.isEmpty) {
      return 'Tidak boleh kosong';
    } else if (!numeric.hasMatch(value)) {
      return "Hanya boleh angka!";
    } else {
      return null;
    }
  }
}
