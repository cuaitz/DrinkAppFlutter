import 'package:drink_app_flutter/view/home_view.dart';
import 'package:go_router/go_router.dart';

class DrinkAppRoutes {
  static const String homeView = '/home';
}

final GoRouter drinkAppRouter = GoRouter(
  initialLocation: DrinkAppRoutes.homeView,
  routes: [
    GoRoute(
      path: DrinkAppRoutes.homeView,
      name: DrinkAppRoutes.homeView,
      builder: (context, state) {
        return HomeView();
      },
    )
  ]
);
