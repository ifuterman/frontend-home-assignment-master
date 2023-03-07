import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/payment_plan.dart';
import '../repository/repository.dart';
import '../utils/safe_coding/either.dart';

part 'payment_bloc.freezed.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentPlanState> {
  PaymentBloc() : super(const PaymentPlanState.initial()) {
    on<_PaymentEventFetch>(_fetch);
    on<_PaymentEventSend>(_send);
  }
  Future _fetch(PaymentEvent event, Emitter<PaymentPlanState> emit) async {
    emit(const PaymentPlanState.initial());
    final res = await Repository.fetchPaymentPlan();
    emit(PaymentPlanState.fetched(res));
  }

  Future _send(_PaymentEventSend event, Emitter<PaymentPlanState> emit) async {
    debugPrint('PaymentBloc._send');
    emit(const PaymentPlanState.initial());
    final res = await Repository.sendPaymentDates(event.plan);
    emit(PaymentPlanState.sent(res));
    debugPrint('PaymentBloc._send completed');
  }
}

@freezed
class PaymentEvent with _$PaymentEvent {
  const factory PaymentEvent.fetch() = _PaymentEventFetch;
  const factory PaymentEvent.send(PaymentPlan plan) = _PaymentEventSend;
}

@freezed
class PaymentPlanState with _$PaymentPlanState {
  /* TODO Iosif: The initial state isn't well defined and used. In practice you
  don't use it at all - you emit it before the calling the endpoints but you
  don't consume or handle it anywhere. */
  const factory PaymentPlanState.initial() = _PaymentPlanStateInitial;
  const factory PaymentPlanState.fetched(Either<String, PaymentPlan> result) =
      _PaymentPlanStateFetched;
  const factory PaymentPlanState.sent(Either<String, String> result) =
      _PaymentStateSent;
}
