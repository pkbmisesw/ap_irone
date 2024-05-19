import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/input_data_controller.dart';

class InputDataView extends GetView<InputDataController> {
  const InputDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: Container(
        decoration: BoxDecoration(),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                ...List.generate(
                  controller.editingControllers.length,
                  (index) => buildTextFormField(
                    index: index,
                    label: controller.datas[index],
                    controller: controller.editingControllers[index],
                    type: controller.keyboardTypes[index],
                    isLast: index == controller.editingControllers.length - 1,
                    validator:
                        controller.keyboardTypes[index] == TextInputType.number
                            ? numberRequired
                            : inputRequired,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: ElevatedButton(
                    onPressed: () {
                      controller.submitData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // atur warna latar belakang menjadi biru
                    ),
                    child: Center(
                      child: Obx(
                        () => controller.loadingBtn.value
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(),
                              )
                            : const Text(
                                "Simpan data",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),

      // body: Form(
      //   key: controller.formKey,
      //   child: SingleChildScrollView(
      //     padding: const EdgeInsets.symmetric(vertical: 30),
      //     child: Column(
      //       children: [
      //         ...List.generate(
      //           controller.editingControllers.length,
      //           (index) => buildTextFormField(
      //             index: index,
      //             label: controller.datas[index],
      //             controller: controller.editingControllers[index],
      //             type: controller.keyboardTypes[index],
      //             isLast: index == controller.editingControllers.length - 1,
      //             validator:
      //                 controller.keyboardTypes[index] == TextInputType.number
      //                     ? numberRequired
      //                     : inputRequired,
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(12),
      //           child: ElevatedButton(
      //             onPressed: () {
      //               controller.submitData();
      //             },
      //             style: ElevatedButton.styleFrom(
      //               primary:
      //                   Colors.blue, // atur warna latar belakang menjadi biru
      //             ),
      //             child: Center(
      //               child: Obx(
      //                 () => controller.loadingBtn.value
      //                     ? const SizedBox(
      //                         height: 24,
      //                         width: 24,
      //                         child: CircularProgressIndicator(),
      //                       )
      //                     : const Text(
      //                         "Simpan data",
      //                         style: TextStyle(color: Colors.white),
      //                       ),
      //               ),
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Widget buildTextFormField({
    required int index,
    required String label,
    required TextEditingController controller,
    required TextInputType type,
    required bool isLast,
    required String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        decoration: InputDecoration(
            labelText: label,
            hintText: "Silahkan Mengisi $label",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  // color: Theme.of(Get.context!).colorScheme.primary,
                  color: Colors.green,
                ))),
        controller: controller,
        enabled: !(index == 0 || index == 2 && controller.text.isNotEmpty),
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
