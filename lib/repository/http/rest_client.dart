import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../dto/account_info_dto.dart';
import '../../dto/payment_dates_dto.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(
      'https://a21wk56avh.execute-api.us-east-1.amazonaws.com/default/flutter-home-exam')
  Future<AccountInfoDto> getAccountInfo();

  @Headers(<String, String>{
    'Content-Type': 'application/json',
    'Content-Length': '-1'
  })
  @POST(
      'https://a21wk56avh.execute-api.us-east-1.amazonaws.com/default/flutter-home-exam')
  Future<String?> sendPaymentDatesInfo(@Body() PaymentDatesDto paymentDates);
}
