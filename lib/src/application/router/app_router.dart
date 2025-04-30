import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sham/features/home/domain/entities/services_entity.dart';
import 'package:sham/features/main/presentation/page/main_screen.dart';
import 'package:sham/features/service_details/presentation/screen/service_details_page.dart';
import 'package:sham/features/sign_in/presentation/pages/sign_in_screen.dart';
import 'package:sham/src/application/router/app_routes.dart';
import 'package:sham/src/application/router/custom_navigation_observer.dart';
import 'package:sham/src/application/router/fallback_screen.dart';

import '../../../features/splash/presentation/screen/splash_screen.dart';

final GlobalKey<NavigatorState> rootKey = GlobalKey<NavigatorState>();

class AppRouter {
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
          path: '${AppRoutes.serviceDetails}',
          name: AppRoutes.serviceDetails,
          // parentNavigatorKey: rootKey,
          
          builder: (BuildContext context, GoRouterState state) {
            final ServicesEntity? services=state.extra as ServicesEntity?;
            // final serviceName = state.pathParameters['name'] ?? '';
            // final serviceImage = state.pathParameters['image'] ?? '';
            // final int serviceId = state.pathParameters['serviceId'] as int;
            // final serviceDescription =
            //     state.pathParameters['description'] ?? '';

            return ServiceDetailsPage(
              services: services,
            );
          },
        ),
      ],
    );
  }
}
