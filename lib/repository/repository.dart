import 'package:dio/dio.dart';

import '../domain/payment_plan.dart';
import '../dto/account_info_dto.dart';
import '../utils/safe_coding/either.dart';
import 'http/rest_client.dart';

class Repository {
  static final client = RestClient(Dio());
  static Future<Either<String, PaymentPlan>> fetchPaymentPlan() async {
    try {
      final res = await client.getAccountInfo().catchError((err) {
        throw Exception('Server error: $err');
      });
      return res.toDomain().fold((l) => left(l), (r) => right(r));
    } catch (ex) {
      return left('Something wrong: $ex');
    }
  }
}
