import 'package:drink_app_flutter/view/drinks_view.dart';
import 'package:drink_app_flutter/view/home_view.dart';
import 'package:drink_app_flutter/view/login_view.dart';
import 'package:drink_app_flutter/view/register_view.dart';
import 'package:go_router/go_router.dart';

class DrinkAppRoutes {
  static const String homeView = '/home';
  static const String loginView = '/login';
  static const String registerView = '/register';
  static const String drinksView = '/drinks';
}

final GoRouter drinkAppRouter = GoRouter(
  initialLocation: DrinkAppRoutes.homeView,
  routes: [
    GoRoute(
      path: DrinkAppRoutes.homeView,
      name: DrinkAppRoutes.homeView,
      builder: (context, state) {
        return HomeView();
      }
    ),
    GoRoute(
      path: DrinkAppRoutes.loginView,
      name: DrinkAppRoutes.loginView,
      builder: (context, state) {
        return LoginView();
      }
    ),
    GoRoute(
      path: DrinkAppRoutes.registerView,
      name: DrinkAppRoutes.registerView,
      builder: (context, state) {
        return RegisterView();
      }
    ),
    GoRoute(
      path: DrinkAppRoutes.drinksView,
      name: DrinkAppRoutes.drinksView,
      builder: (context, state) {
        return DrinksView();
      }
    ),
  ]
);
