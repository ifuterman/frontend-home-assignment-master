import 'package:freezed_annotation/freezed_annotation.dart';
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
