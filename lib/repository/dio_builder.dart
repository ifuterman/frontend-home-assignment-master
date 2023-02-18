import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'http/rest_client.dart';

class DioBuilder {
  late final RestClient _client;
  RestClient get client => _client;
  DioBuilder() {
    final dio = Dio();
    _client = RestClient(dio);
    dio.interceptors.add(
        PrettyDioLogger(requestBody: true, requestHeader: true, request: true));
  }
}
