import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final _su = ScreenUtil();
bool isAdopt() => true;

double? get pixelRatio => ScreenUtil().pixelRatio;

double get screenWidth => ScreenUtil().screenWidth;

double? get scaleWidth => ScreenUtil().scaleWidth;

double get screenHeight => ScreenUtil().screenHeight;

double? get scaleHeight => ScreenUtil().scaleHeight;

extension NumX on num {
  double get r => isAdopt() ? _su.radius(this) : toDouble();

  double get sp => isAdopt() ? _su.setSp(this) : toDouble();

  double get w => isAdopt() ? _su.setWidth(this) : toDouble();

  double get w0 => toDouble();

  double get h => isAdopt() ? _su.setHeight(this) : toDouble();

  double get h0 => toDouble();

  SizedBox get sbHeight =>
      SizedBox(height: isAdopt() ? _su.setHeight(this) : toDouble());

  SizedBox get sbHeightFromWidth =>
      SizedBox(height: isAdopt() ? _su.setWidth(this) : toDouble());

  /// Это все равно что по минимальному коэффициенту
  SizedBox get sbHeightFromRadius =>
      SizedBox(height: isAdopt() ? _su.radius(this) : toDouble());

  SizedBox get sbHeight0 => SizedBox(height: toDouble());

  SizedBox get sbWidth =>
      SizedBox(width: isAdopt() ? _su.setWidth(this) : toDouble());

  SizedBox get sbWidthFromHeight =>
      SizedBox(width: isAdopt() ? _su.setHeight(this) : toDouble());

  /// Это все равно что по минимальному коэффициенту
  SizedBox get sbWidthFromRadius =>
      SizedBox(width: isAdopt() ? _su.radius(this) : toDouble());

  SizedBox get sbWidth0 => SizedBox(width: toDouble());

  EdgeInsets get insetsHor => EdgeInsets.symmetric(horizontal: this * 1.0);

  EdgeInsets get insetsVert => EdgeInsets.symmetric(vertical: this * 1.0);

  EdgeInsets get insetsAll => EdgeInsets.all(this * 1.0);
}

extension StringX on String {
  /// Обрезать строку, если больше максимальной длины
  String crop(int maxLength) {
    assert(maxLength > -1, 'Must be positive');
    return length <= maxLength ? this : substring(0, maxLength);
  }

  ///
  String safeEnds(int endLength, {String delimiter = '..'}) {
    assert(endLength > -1, 'Must be positive');
    if (endLength == 0) {
      return this;
    }
    if (endLength * 2 >= length) {
      return this;
    }
    final start = substring(0, endLength);
    final end = substring(length - endLength, length);
    return '$start$delimiter$end';
  }
}
