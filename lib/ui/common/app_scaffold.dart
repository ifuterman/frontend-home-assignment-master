import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child, this.backgroundColor});
  final Widget child;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    final overlayStyle = Platform.isIOS
        ? const SystemUiOverlayStyle(statusBarBrightness: Brightness.light)
        : const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light);
    return AnnotatedRegion(
      value: overlayStyle,
      child: Scaffold(
        primary: false,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          bottom: false,
          child: child,
        ),
      ),
    );
  }
}
