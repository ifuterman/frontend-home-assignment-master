import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/payment.dart';

part 'payment_dto.g.dart';

@JsonSerializable()
class PaymentDto {
  String? date;
  int? amount;

  PaymentDto({this.date, this.amount});

  factory PaymentDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDtoToJson(this);
}

extension PaymentDtoX on PaymentDto {
  Payment toDomain() {
    final value = (amount ?? 0).toDouble() / 100;

    /// TODO Iosif: The use of " ?? DateTime.now()" can lead to incorrect output
    /// in case of a server error
    return Payment(
        amount: value, date: DateTime.tryParse(date ?? '') ?? DateTime.now());
  }
}
