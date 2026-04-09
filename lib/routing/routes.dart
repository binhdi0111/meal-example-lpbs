import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/routing/helper/route_data.dart';
import 'package:clean_architecture/routing/routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(page: MealListRoute.page, path: kMealListPath, initial: true),
    AutoRoute(page: MealDetailRoute.page, path: '/meal-detail'),
  ];
}
