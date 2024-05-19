import 'package:irone/app/data/models/letter/letter_model.dart';
import 'package:irone/app/utils/constants_endpoints.dart';

import 'base_dio.dart';

class LetterServices {
  final dio = BaseDio().dio;

  //* INCOMING LETTER
  Future<LetterModel> getIncomingLetter() {
    dio.options.baseUrl = ConstantsEndpoints.main;

    return dio
        .get('suratmasuk')
        .then((value) => LetterModel.fromJson(value.data));
  }

  //* OUTGOING LETTER
  Future<LetterModel> getOutgoingLetter() {
    dio.options.baseUrl = ConstantsEndpoints.main;

    return dio
        .get('suratkeluar')
        .then((value) => LetterModel.fromJson(value.data));
  }
}
