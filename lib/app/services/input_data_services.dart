import 'package:irone/app/data/models/input_data.dart';
import 'package:irone/app/services/base_dio.dart';
import 'package:irone/app/utils/constants_endpoints.dart';

class InputDataServices {
  final dio = BaseDio().dio;

  Future<String> submitData(InputDataModel data) {
    dio.options.baseUrl = ConstantsEndpoints.main;
    return dio
        .post('add-barang-rekap', data: data.toJson())
        .then((value) => value.data["message"]);
  }
}
