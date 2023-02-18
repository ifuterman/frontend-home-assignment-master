import 'package:flutter/material.dart';

import '../bloc/payment_bloc.dart';
import '../domain/payment_plan.dart';

class TestService {
  final paymentBloc = PaymentBloc();
  void fetchPaymentPlan() {
    paymentBloc.add(const PaymentEvent.fetch());
  }

  void sendPaymentDates(PaymentPlan plan) {
    debugPrint('TestService.sendPaymentDates');
    paymentBloc.add(PaymentEvent.send(plan));
  }
}

final appService = TestService();
