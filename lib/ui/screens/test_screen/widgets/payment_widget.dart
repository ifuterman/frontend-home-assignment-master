import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_extensions.dart';
import '../../../common/app_styles.dart';
import '../../../common/riverpod_widget.dart';
import '../test_screen_controller.dart';

class PaymentWidget extends RiverpodWidget<PaymentWidgetController> {
  PaymentWidget(
      {Key? key,
      required int paymentIndex,
      required TestScreenController controller})
      : super(
            key: key,
            builder: () => PaymentWidgetController(controller, paymentIndex));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(controller.dateNotifierProvider);
    return SizedBox(
      width: 60.w,
      child: Column(
        children: [
          Text(DateFormat('MM/dd').format(date),
              style: AppStyles.text14.andWeight(FontWeight.w400)),
          GestureDetector(
            onTap: () => controller.onButtonPressed(context, ref),
            child: Container(
              width: 12.r,
              height: 12.r,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: AppColors.defaultWidgetBackground,
                  border: Border.all(
                      color: AppColors.defaultBorderColor, width: 1)),
              child: Container(
                width: 10.r,
                height: 10.r,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    gradient: AppColors.defaultRoundGradient,
                    border: Border.all(
                        color: AppColors.defaultWidgetBackground, width: 1)),
              ),
            ),
          ),
          Text(
            controller.amount,
            style: AppStyles.text14.copyWith(fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

class PaymentWidgetController extends RiverpodController<PaymentWidget> {
  TestScreenController controller;
  final int paymentIndex;
  late final StateNotifierProvider<DateNotifier, DateTime> dateNotifierProvider;

  PaymentWidgetController(this.controller, this.paymentIndex) {
    dateNotifierProvider = StateNotifierProvider<DateNotifier, DateTime>(
        (ref) => DateNotifier(controller.plan.payments[paymentIndex].date));
  }

  String get amount {
    final amount = controller.plan.payments[paymentIndex].amount;
    final decimalDigits = amount == amount.roundToDouble() ? 0 : 2;
    return NumberFormat.currency(
            locale: 'en_us',
            name: 'us',
            symbol: '\$',
            decimalDigits: decimalDigits)
        .format(amount);
  }

  Future<void> onButtonPressed(BuildContext context, WidgetRef ref) async {
    DateTime firstDate;
    if (paymentIndex == 0) {
      final date = controller.plan.payments[paymentIndex].date;
      firstDate = DateTime(date.year, date.month, 1);
      if (firstDate.isBefore(DateTime.now())) {
        firstDate = DateTime.now();
      }
    } else {
      firstDate = controller.plan.payments[paymentIndex - 1].date
          .add(const Duration(days: 1));
    }
    DateTime lastDate;
    if (paymentIndex == controller.plan.payments.length - 1) {
      final month = controller.plan.payments[paymentIndex].date.month;
      final year = DateTime.now().year;
      lastDate =
          month < 12 ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);
    } else {
      lastDate = controller.plan.payments[paymentIndex + 1].date
          .subtract(const Duration(days: 1));
    }
    final date = await showDatePicker(
      context: context,
      initialDate: controller.plan.payments[paymentIndex].date,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (date != null) {
      controller.changePaymentDate(paymentIndex, date);
      ref.read(dateNotifierProvider.notifier).setDate(date);
    }
  }
}

class DateNotifier extends StateNotifier<DateTime> {
  DateNotifier(super.state);
  void setDate(DateTime date) => state = date;
}
