import 'package:dio/dio.dart';

class BaseDio {
  static final _options = BaseOptions(
    // baseUrl: ConstantsEndpoints.main,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      Headers.acceptHeader: Headers.jsonContentType,
    },
    contentType: Headers.jsonContentType,
  );

  final _dio = Dio(_options);

  Dio get dio => _dio;
}
