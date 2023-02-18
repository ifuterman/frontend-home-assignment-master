import 'package:flutter/material.dart';

import '../app_colors.dart';

class AppButton extends StatelessWidget {
  final double width;
  final double height;
  final Function() onPressed;
  final Color? color;
  final double borderRadius;
  final Widget child;
  final Color borderColor;
  final double borderWidth;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;

  const AppButton(
      {Key? key,
      this.width = 50,
      this.height = 50,
      required this.onPressed,
      this.color,
      this.borderRadius = 10,
      required this.child,
      this.borderColor = AppColors.defaultBorderColor,
      this.borderWidth = 2,
      this.gradient,
      this.boxShadow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        boxShadow: boxShadow,
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Ink(
        width: width - 4,
        height: height - 4,
        decoration: BoxDecoration(
          gradient: gradient,
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: Colors.white,
          highlightColor: Colors.white,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
