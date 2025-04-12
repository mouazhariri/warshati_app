import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:warshati/features/main/presentation/page/main_screen.dart';
import 'package:warshati/features/service_details/presentation/screen/service_details_page.dart';
import 'package:warshati/features/sign_in/presentation/pages/sign_in_screen.dart';
import 'package:warshati/src/application/router/app_routes.dart';
import 'package:warshati/src/application/router/custom_navigation_observer.dart';
import 'package:warshati/src/application/router/fallback_screen.dart';

import '../../../features/splash/presentation/screen/splash_screen.dart';

final GlobalKey<NavigatorState> rootKey = GlobalKey<NavigatorState>();

// class AppRouter {
//   final GoRouter goRouter;

//   AppRouter() : goRouter = _getRouter;

//   static late AppRouter _appRouter;

//   static init() {
//     _appRouter = AppRouter();
//   }

//   static get getRouter => _appRouter.goRouter;
//   static get _getRouter => GoRouter(
//       navigatorKey: rootKey,
//       initialLocation: AppRoutes.initScreen,
//       observers: [CustomNavigationObserver()],
//       errorBuilder: (context, state) => const FallbackScreen(),
//       routes: <RouteBase>[
//         GoRoute(
//           path: AppRoutes.initScreen,
//           parentNavigatorKey: rootKey,
//           builder: (BuildContext context, GoRouterState state) {
//             return Scaffold(
//               body: Container(
//                 color: Colors.grey,
//               ),
//             );
//           },
//         ),
//       ]);
// }
class AppRouter {
  // static final _router = AppRouter._internal();

  // factory AppRouter() => _router;

  final GoRouter goRouter;

  AppRouter(String initialRoute) : goRouter = _createRouter(initialRoute);

  static GoRouter _createRouter(initialRoute) {
    return GoRouter(
      navigatorKey: rootKey,
      initialLocation: initialRoute,
      observers: [CustomNavigationObserver()],
      errorBuilder: (context, state) => const FallbackScreen(),
      routes: <RouteBase>[
        GoRoute(
          path: AppRoutes.splashScreen,
          parentNavigatorKey: rootKey,
          builder: (BuildContext context, GoRouterState state) {
            return SplashScreen();
          },
        ),
        GoRoute(
          path: AppRoutes.signInScreen,
          parentNavigatorKey: rootKey,
          builder: (BuildContext context, GoRouterState state) {
            return SignInScreen();
          },
        ),
        GoRoute(
          path: AppRoutes.homeScreen,
          parentNavigatorKey: rootKey,
          builder: (BuildContext context, GoRouterState state) {
            return MainScreen();
          },
        ),
        GoRoute(
          path: '${AppRoutes.serviceDetails}/:name/:image/:description',
          name: AppRoutes.serviceDetails,
          parentNavigatorKey: rootKey,
          builder: (BuildContext context, GoRouterState state) {
            final serviceName = state.pathParameters['name'] ?? '';
            final serviceImage = state.pathParameters['image'] ?? '';
            final serviceDescription =
                state.pathParameters['description'] ?? '';

            return ServiceDetailsPage(
              serviceName: serviceName,
              serviceImage: serviceImage,
              serviceDescription: serviceDescription,
            );
          },
        ),
      ],
    );
  }
}
