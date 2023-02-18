import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';
import '../domain/payment_plan.dart';
import '../repository/repository.dart';
import '../utils/safe_coding/either.dart';

part 'payment_bloc.freezed.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentPlanState> {
  PaymentBloc() : super(const PaymentPlanState.initial()) {
    on<_PaymentEventFetch>(_fetch);
  }
  Future _fetch(PaymentEvent event, Emitter<PaymentPlanState> emit) async {
    emit(const PaymentPlanState.initial());
    final res = await Repository.fetchPaymentPlan();
    emit(PaymentPlanState.fetched(res));
  }
}

@freezed
class PaymentEvent with _$PaymentEvent {
  const factory PaymentEvent.fetch() = _PaymentEventFetch;
}

@freezed
class PaymentPlanState with _$PaymentPlanState {
  const factory PaymentPlanState.initial() = _PaymentPlanStateInitial;
  const factory PaymentPlanState.fetched(Either<String, PaymentPlan> result) =
      _PaymentPlanStatePassed;
}
