import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend_home_assignment/screens/router/root_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).whenComplete(() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  });
  runZonedGuarded(
          () => runApp(
        // For widgets to be able to read providers, we need to wrap the entire
        // application in a "ProviderScope" widget.
        // This is where the state of our providers will be stored.
        const ProviderScope(child: MyApp()),
      ),
          (error, stack) {});
}

// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, _) {
        return Builder(
          builder: (context) {
            return MaterialApp.router(
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              routerDelegate: AppRouter.delegate(),
              routeInformationProvider: AppRouter.routeInfoProvider(),
              routeInformationParser: AppRouter.defaultRouteParser(),
              debugShowCheckedModeBanner: false,
              // localizationsDelegates: context.localizationDelegates,
              // supportedLocales: context.supportedLocales,
              // locale: context.locale,
              // localeResolutionCallback: (deviceLocale, supportedLocales) {
              //   if (deviceLocale != null) {
              //     ref.read(languageProvider.notifier).changeCurrentLanguage(
              //         Language.fromLocale(deviceLocale), context);
              //   }
              //   return language.toLocale;
              // },
            );
          },
        );
      },
    );
  }
}

