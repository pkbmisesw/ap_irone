import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:silahan_kawan/app/modules/detail_pkk/model/image_model.dart';

class DetailPkkServices {
  String? baseUrl = dotenv.env['BASE_URL'];

  Future<String> getImage(String value) async {
    final url = '${baseUrl}$value';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      final imageData = ImageModel.fromJson(data[0]);
      final image = imageData.pic;
      return image;
    } else {
      return '';
    }
  }
}
