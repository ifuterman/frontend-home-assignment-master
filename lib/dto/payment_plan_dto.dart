import 'package:freezed_annotation/freezed_annotation.dart';
import 'payment_dto.dart';

part 'payment_plan_dto.g.dart';

@JsonSerializable()
class PaymentPlanDto {
  String? id;
  List<PaymentDto>? payments;

  PaymentPlanDto(this.id, this.payments);

  factory PaymentPlanDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentPlanDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentPlanDtoToJson(this);
}
