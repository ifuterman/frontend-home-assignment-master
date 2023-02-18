import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/payment_plan.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_extensions.dart';
import '../../../common/app_styles.dart';
import '../../../common/riverpod_widget.dart';
import '../../../common/widgets/app_button.dart';
import '../test_screen_controller.dart';
import 'payment_widget.dart';

class PaymentPlanWidget extends RiverpodWidget<PaymentWidgetController> {
  PaymentPlanWidget({Key? key, required TestScreenController controller})
      : super(builder: () => PaymentWidgetController(controller), key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plan = ref.watch(controller.paymentPlanTypeProvider);
    return Container(
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[AppColors.defaultShadow],
          color: AppColors.defaultWidgetBackground,
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          border: Border.all(color: AppColors.defaultBorderColor, width: 2.r)),
      child: Column(
        children: [
          22.sbHeight,
          Row(
            children: [
              const Spacer(),
              Row(
                children: List.generate(
                    5,
                    (index) =>
                        generatePaymentPlanSelectorElement(index, ref, plan)),
              ),
              const Spacer()
            ],
          ),
          27.sbHeight,
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  19.sbHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1.w,
                        width: 180.w,
                        color: AppColors.lineColor,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    controller.controller.plan.payments.length * 2 - 1,
                    generatePaymentWidget),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget generatePaymentPlanSelectorElement(
      int index, WidgetRef ref, PaymentPlanType currentType) {
    if (index.isOdd) {
      return 18.sbWidth;
    }
    var planIndex = index ~/ 2;
    final type = PaymentPlanType.values[planIndex];
    return AppButton(
        onPressed: () =>
            controller.onPaymentsClick(ref, PaymentPlanType.values[planIndex]),
        color: AppColors.defaultWidgetBackground,
        gradient: type == currentType ? AppColors.defaultGradient : null,
        borderRadius: 14.5.r,
        borderColor: AppColors.defaultBorderColor,
        borderWidth: 2.w,
        child: Text(
          '${index ~/ 2 + 2}', //generating labels for button
          style: AppStyles.text18
              .andWeight(FontWeight.w800)
              .andColor(AppColors.textBlack),
        ));
  }

  Widget generatePaymentWidget(int index) {
    if (index.isOdd) {
      double width;
      switch (controller.controller.plan.type) {
        case PaymentPlanType.twoPayment:
          width = 120.w;
          break;
        case PaymentPlanType.threePayment:
          width = 30.w;
          break;
        case PaymentPlanType.fourPayment:
          width = 0;
          break;
      }
      return Opacity(
          opacity: 0,
          child: Container(
            width: width,
          ));
    }

    var paymentIndex = index ~/ 2;
    return PaymentWidget(
      paymentIndex: paymentIndex,
      controller: controller.controller,
    );
  }
}

class PaymentWidgetController extends RiverpodController<PaymentPlanWidget> {
  final TestScreenController controller;
  late final StateNotifierProvider<PaymentsPlanTypeNotifier, PaymentPlanType>
      paymentPlanTypeProvider;
  PaymentWidgetController(this.controller) {
    paymentPlanTypeProvider =
        StateNotifierProvider<PaymentsPlanTypeNotifier, PaymentPlanType>(
            (_) => PaymentsPlanTypeNotifier(controller.plan.type));
  }
  void onPaymentsClick(WidgetRef ref, PaymentPlanType type) {
    controller.changePlanType(type);
    ref.read(paymentPlanTypeProvider.notifier).setPlan(type);
  }
}

class PaymentsPlanTypeNotifier extends StateNotifier<PaymentPlanType> {
  PaymentsPlanTypeNotifier(super.state);
  void setPlan(PaymentPlanType type) => state = type;
}
