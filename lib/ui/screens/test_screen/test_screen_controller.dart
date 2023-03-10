import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../bloc/payment_bloc.dart';
import '../../../domain/payment.dart';
import '../../../domain/payment_plan.dart';
import '../../../service/test_service.dart';
import '../../../utils/subscriber_mixin.dart';
import '../router/root_router.dart';

class TestScreenController with SubscriberMixin {
  final formatter = NumberFormat.currency(
      locale: 'en_us', name: 'us', symbol: '\$', decimalDigits: 2);
  PaymentPlan _plan;
  TestScreenController(this._plan);
  String get amount {
    return formatter.format(plan.amount);
  }

  PaymentPlan get plan => _plan;

  void init() {
    debugPrint('TestScreenController.init');
    subscribeIt(appService.paymentBloc.stream.listen(processPaymentState));
  }

  void dispose() {
    unsubscribeAll();
  }

  void processPaymentState(PaymentPlanState state) {
    debugPrint('TestScreenController.processPaymentState');
    state.maybeWhen(
        sent: (res) {
          res.fold((l) {
            Widget okButton = TextButton(
              onPressed: () {
                Navigator.of(appContext).pop();
              },
              child: const Text("OK"),
            );

            // set up the AlertDialog
            final alert = AlertDialog(
              title: const Text('ERROR'),
              content: Text(l),
              actions: [
                okButton,
              ],
            );
            showDialog(context: appContext, builder: (context) => alert);
          }, (r) {
            Widget okButton = TextButton(
              onPressed: () {
                Navigator.of(appContext).pop();
              },
              child: const Text("OK"),
            );

            // set up the AlertDialog
            final alert = AlertDialog(
              title: const Text('MESSAGE'),
              content: const Text('SUCCESS'),
              actions: [
                okButton,
              ],
            );
            showDialog(context: appContext, builder: (context) => alert);
          });
        },
        orElse: () {});
  }

  void changePlanType(PaymentPlanType type) {
    if (type == _plan.type) {
      return;
    }
    var payments = List<Payment>.from(_plan.payments);
    final newPaymentCount = type.index + 2;
    var amount = _plan.amount / newPaymentCount;
    amount = amount.roundToDouble();
    final sum = amount * newPaymentCount;
    final dif = sum == _plan.amount ? 0 : _plan.amount - sum;
    for (var i = 0; i < payments.length; i++) {
      payments[i] =
          payments[i].copyWith(amount: i == 0 ? amount + dif : amount);
    }
    if (type.index < _plan.type.index) {
      //here we are removing extra payments
      while (payments.length > type.index + 2) {
        payments.removeAt(1);
      }
    } else if (type.index > _plan.type.index) {
      var newDate = _plan.payments[0].date.add(const Duration(days: 1));
      var index = 1;
      //here we are adding new payments
      while (payments.length < type.index + 2) {
        payments.insert(index, Payment(amount: amount, date: newDate));
        newDate = newDate.add(const Duration(days: 1));
        index++;
      }
    }
    _plan = _plan.copyWith(type: type, payments: payments);
  }

  void changePaymentDate(int index, DateTime date) {
    if (_plan.payments.length <= index) {
      return;
    }
    var payments = List<Payment>.from(plan.payments);
    payments[index] = payments[index].copyWith(date: date);
    _plan = _plan.copyWith(payments: payments);
  }

  void onSplitMyRent() {
    debugPrint('TestScreenController.onSplitMyRent');
    appService.sendPaymentDates(plan);
  }
}
