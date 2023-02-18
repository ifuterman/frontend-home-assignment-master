import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppStyles {
  static const font = 'roboto';

  static final text9 = _textStyle(9);

  static final text10 = _textStyle(10);

  static final text11 = _textStyle(11);

  static final text12 = _textStyle(12);

  static final text13 = _textStyle(13);

  static final text14 = _textStyle(14);

  static final text15 = _textStyle(15);

  static final text16 = _textStyle(16);

  static final text17 = _textStyle(17);

  static final text18 = _textStyle(18);

  static final text20 = _textStyle(20);

  static final text22 = _textStyle(22);

  static final text24 = _textStyle(24);

  static final text25 = _textStyle(25);

  static final text36 = _textStyle(36);

  static TextStyle _textStyle(double fontSize) => TextStyle(
        fontSize: fontSize.sp,
        fontFamily: font,
        color: AppColors.plainText,
        decoration: null,
        decorationColor: Colors.white,
      );
}

extension TextStyleX on TextStyle {
  TextStyle andSize(double size) => copyWith(fontSize: size);

  TextStyle andWeight(FontWeight weight) => copyWith(fontWeight: weight);

  TextStyle andFontSize(double size) => copyWith(fontSize: size);

  TextStyle andHeight(double height) => copyWith(height: height);

  TextStyle andColor(Color color) => copyWith(color: color);

  TextStyle andUnderline() => copyWith(decoration: TextDecoration.underline);
}
