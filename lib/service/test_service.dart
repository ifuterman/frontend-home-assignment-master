import '../bloc/payment_bloc.dart';

class TestService {
  final paymentBloc = PaymentBloc();
  void fetchPaymentPlan() {
    paymentBloc.add(const PaymentEvent.fetch());
  }
}

final appService = TestService();
