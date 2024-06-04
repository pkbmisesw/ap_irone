import 'package:silahan_kawan/app/utils/constants_endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewer extends StatelessWidget {
  const PDFViewer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urlPDF = Get.arguments as String;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SfPdfViewer.network('${ConstantsEndpoints.urlImgBanner}$urlPDF'),
    );
  }
}
