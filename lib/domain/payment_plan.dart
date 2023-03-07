import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import '../dto/payment_dates_dto.dart';
import 'payment.dart';

part 'payment_plan.freezed.dart';
part 'payment_plan.g.dart';

@freezed
class PaymentPlan with _$PaymentPlan {
  const factory PaymentPlan(
      {required String id,
      required double amount,
      required PaymentPlanType type,
      required List<Payment> payments}) = _PaymentPlan;
  factory PaymentPlan.fromJson(Map<String, dynamic> json) =>
      _$PaymentPlanFromJson(json);
}

enum PaymentPlanType { twoPayment, threePayment, fourPayment }

extension PaymentPlanX on PaymentPlan {
  PaymentDatesDto toDto() {
    final formatter = DateFormat('yyyy-MM-ddThh:mm.000');
    final dates = <String>[];
    for (final p in payments) {
      // TODO Iosif - better to call p.date.toIso8601String()
      dates.add('${formatter.format(p.date)}Z');
    }
    return PaymentDatesDto(id: int.tryParse(id) ?? 0, dates: dates);
  }
}
