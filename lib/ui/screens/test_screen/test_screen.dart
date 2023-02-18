import 'package:flutter/material.dart';

import '../../common/app_colors.dart';
import '../../common/app_extensions.dart';
import '../../common/app_icons.dart';
import '../../common/app_literals.dart';
import '../../common/app_scaffold.dart';
import '../../common/app_styles.dart';
import '../../common/widgets/app_button.dart';
import 'test_screen_controller.dart';
import 'widgets/payment_plan_widget.dart';

class TestScreen extends StatelessWidget {
  late final TestScreenController controller;
  TestScreen({super.key}) {
    controller = TestScreenController();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.defaultBackground,
      child: Column(
        children: [
          22.sbHeight,
          Container(
            padding: EdgeInsets.only(left: 150.w, right: 150.w),
            child: Image.asset(AppIcons.logoPath),
          ),
          99.sbHeight,
          Text(
            AppLiterals.testScreenYourRent,
            style: AppStyles.text14.andWeight(FontWeight.w400),
          ),
          8.sbHeight,
          Text(
            controller.amount,
            style: AppStyles.text20.andWeight(FontWeight.w400),
          ),
          65.sbHeight,
          Text(
            AppLiterals.testScreenYourPlan,
            style: AppStyles.text14.andWeight(FontWeight.w400),
          ),
          10.sbHeight,
          Container(
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              child: PaymentPlanWidget(controller: controller)
          ),
          91.sbHeight,
          AppButton(
              onPressed: controller.onSplitMyRent,
              gradient: AppColors.defaultGradient,
              width: 304.w,
              height: 41.h,
              borderWidth: 0,
              borderRadius: 5.r,
              boxShadow: [AppColors.buttonShadow],
              child: Text(
                AppLiterals.testScreenSplitRent,
                style: AppStyles.text16.andWeight(FontWeight.w600).andColor(AppColors.textWhite),
              ))
        ],
      ),
    );
  }
}
