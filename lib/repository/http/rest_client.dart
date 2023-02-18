import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../dto/account_info_dto.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: "https://script.google.com/macros/s/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(
      'AKfycbxMUT8QCMuTWRiKDUx34gSzu_1O29stPJpZCpq1UWVN3q2jBpgQuw8eLH_i5BwkOYLmFA/exec')
  Future<AccountInfoDto> getAccountInfo();
}
