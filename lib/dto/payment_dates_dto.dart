import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_dates_dto.g.dart';

@JsonSerializable()
class PaymentDatesDto {
  int id;
  List<String> dates;
  PaymentDatesDto({required this.id, required this.dates});

  factory PaymentDatesDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentDatesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDatesDtoToJson(this);
}
