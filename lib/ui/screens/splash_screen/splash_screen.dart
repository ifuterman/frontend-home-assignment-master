import 'package:flutter/material.dart';

import '../../common/app_colors.dart';
import '../../common/app_icons.dart';
import '../../common/app_scaffold.dart';
import 'splash_screen_controller.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  final controller = SplashScreenController();

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
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
