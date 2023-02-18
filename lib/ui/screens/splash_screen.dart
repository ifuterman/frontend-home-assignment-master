import 'package:flutter/material.dart';
import 'package:frontend_home_assignment/ui/screens/router/root_router.gr.dart';

import '../../bloc/payment_bloc.dart';
import '../../service/test_service.dart';
import '../../utils/subscriber_mixin.dart';
import '../common/app_colors.dart';
import '../common/app_icons.dart';
import '../common/app_scaffold.dart';
import 'router/root_router.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  final controller = SplashScreenController();

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        backgroundColor: AppColors.defaultBackground,
        child: Center(child: Image.asset(AppIcons.logoPath)));
  }

  @override
  void initState() {
    super.initState();
    widget.controller.init();
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }
}

class SplashScreenController with SubscriberMixin {
  void init() {
    subscribeIt(appService.paymentBloc.stream.listen(processPaymentEvents));
    appService.fetchPaymentPlan();
  }

  void processPaymentEvents(PaymentPlanState event) {
    debugPrint('SplashScreenController.processPaymentEvents');
    event.when(
        initial: () {},
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
        });
  }

  void dispose() {
    unsubscribeAll();
  }
}
