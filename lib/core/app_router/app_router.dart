import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.cupertino(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    AutoRoute(initial: true, page: SplashRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: BookshelfRoute.page),
    AutoRoute(page: AccountRoute.page),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: ExtensionsRoute.page),
    AutoRoute(page: SourcesRoute.page),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    // optionally add root guards here
  ];
}
