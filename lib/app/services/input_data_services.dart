import 'package:silahan_kawan/app/data/models/input_data.dart';
import 'package:silahan_kawan/app/services/base_dio.dart';
import 'package:silahan_kawan/app/utils/constants_endpoints.dart';

class InputDataServices {
  final dio = BaseDio().dio;

  Future<String> submitData(InputDataModel data) {
    dio.options.baseUrl = ConstantsEndpoints.main;
    return dio
        .post('add-barang-rekap', data: data.toJson())
        .then((value) => value.data["message"]);
  }
}
