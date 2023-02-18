import 'package:auto_route/auto_route.dart';

import '../splash_screen.dart';
import '../test_screen/test_screen.dart';
import 'root_router.gr.dart';

@MaterialAutoRouter(replaceInRouteName: 'Screen,Route', routes: <AutoRoute>[
  AutoRoute(page: SplashScreen, initial: true),
  AutoRoute(page: TestScreen, initial: false),
]
    // replaceInRouteName: 'Screen|Dialog,Route',
    // routes: <AutoRoute>[
    //   RedirectRoute(path: '*', redirectTo: '/'),
    //   CustomRoute(page: TabletsScreen, initial: true),
    //   CustomRoute(
    //     page: SplashScreen,
    //     transitionsBuilder: TransitionsBuilders.fadeIn,
    //     durationInMilliseconds: 500,
    //   ),
    // ]
    )
class $RootRouter {}

// ignore: non_constant_identifier_names
final AppRouter = RootRouter();
final appContext = AppRouter.navigatorKey.currentContext!;
