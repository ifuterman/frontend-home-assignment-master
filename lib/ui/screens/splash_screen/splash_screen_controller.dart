import 'package:flutter/material.dart';

import '../../../bloc/payment_bloc.dart';
import '../../../service/test_service.dart';
import '../../../utils/subscriber_mixin.dart';
import '../router/root_router.dart';
import '../router/root_router.gr.dart';

class SplashScreenController with SubscriberMixin {
  void init() {
    subscribeIt(appService.paymentBloc.stream.listen(processPaymentEvents));
    appService.fetchPaymentPlan();
  }

  void processPaymentEvents(PaymentPlanState event) {
    event.maybeWhen(
        fetched: (res) {
          res.fold((l) {
            Widget okButton = TextButton(
              onPressed: init,
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
          }, (r) => AppRouter.popAndPush(TestRoute(plan: r)));
        },
        orElse: () {});
  }

  void dispose() {
    unsubscribeAll();
  }
}
