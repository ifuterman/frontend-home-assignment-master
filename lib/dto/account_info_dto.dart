import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/payment.dart';
import '../domain/payment_plan.dart';
import '../utils/safe_coding/either.dart';
import 'payment_dto.dart';
import 'payment_plan_dto.dart';

part 'account_info_dto.g.dart';

@JsonSerializable()
class AccountInfoDto {
  int? amount;
  List<PaymentPlanDto>? paymentPlans;

  factory AccountInfoDto.fromJson(Map<String, dynamic> json) =>
      _$AccountInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AccountInfoDtoToJson(this);

  AccountInfoDto(this.amount, this.paymentPlans);
}

extension AccountInfoDtoX on AccountInfoDto {
  Either<String, PaymentPlan> toDomain() {
    final value = (amount ?? 0).toDouble() / 100;
    if (paymentPlans == null || paymentPlans!.isEmpty) {
      return left('Wrong data format');
    }
    if (paymentPlans![0].payments == null ||
        paymentPlans![0].payments!.length < 2 ||
        paymentPlans![0].payments!.length > 4) {
      return left('Wrong data format');
    }
    final payments = <Payment>[];
    for (final dp in paymentPlans![0].payments!) {
      payments.add(dp.toDomain());
    }
    final id = paymentPlans![0].id ?? '';
    var type = PaymentPlanType.values[payments.length - 2];
    return right(
        PaymentPlan(id: id, amount: value, type: type, payments: payments));
  }
}
