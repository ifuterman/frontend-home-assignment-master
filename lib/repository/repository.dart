import '../domain/payment_plan.dart';
import '../dto/account_info_dto.dart';
import '../utils/safe_coding/either.dart';
import 'dio_builder.dart';
import 'http/rest_client.dart';

class Repository {
  static final dioBuilder = DioBuilder();
  static RestClient get client => dioBuilder.client;
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

  static Future<Either<String, String>> sendPaymentDates(
      PaymentPlan plan) async {
    try {
      final dto = plan.toDto();
      final res = await client.sendPaymentDatesInfo(dto);
      if (res == null || res.isEmpty) {
        return right('');
      }
      return left(res);
    } catch (ex) {
      return left('Something wrong: $ex');
    }
  }
}
