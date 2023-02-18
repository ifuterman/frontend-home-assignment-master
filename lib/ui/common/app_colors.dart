import 'package:flutter/material.dart';

import 'app_extensions.dart';

class AppColors {
  static const defaultBackground = Color(0xFFF5F5F5);
  static const defaultWidgetBackground = Color(0xFFFFFFFF);
  static const defaultBorderColor = Color(0xFF2EC790);
  static const plainText = Color(0xFF2C2C63);
  static const textBlack = Color(0xFF000000);
  static const textWhite = Color(0xFFFFFFFF);
  static const lineColor = Color.fromRGBO(0, 0, 0, 0.2);
  static BoxShadow defaultShadow = BoxShadow(
      color: const Color.fromRGBO(0, 0, 0, 0.1),
      blurRadius: 30.r,
      spreadRadius: 0,
      offset: const Offset(0, 1));
  static BoxShadow buttonShadow = BoxShadow(
      color: const Color.fromRGBO(0, 0, 0, 0.2),
      blurRadius: 10.r,
      spreadRadius: 0,
      offset: const Offset(0, 2));
  static const defaultGradient = LinearGradient(
      colors: [Color(0xFF01BB78), Color(0xFF1CD3BD)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight);
  static const buttonGradient = LinearGradient(
      colors: [Color(0xFF00BA77), Color(0xFF1BD2BC)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight);
  static const defaultRoundGradient = RadialGradient(
    colors: [
      Color(0xFF2EC790),
      Color.fromRGBO(126, 220, 187, 0.61),
      Color(0x00000000)
    ],
  );
}
