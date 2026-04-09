import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture/routing/routes.gr.dart';

final class AuthenticatedGuard extends AutoRouteGuard {
  const AuthenticatedGuard();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    router.replaceAll([const MealListRoute()]);
    resolver.next(false);
  }
}
