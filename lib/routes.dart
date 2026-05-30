import 'package:drink_app_flutter/view/drink_details_view.dart';
import 'package:drink_app_flutter/view/drinks_view.dart';
import 'package:drink_app_flutter/view/home_view.dart';
import 'package:drink_app_flutter/view/login_view.dart';
import 'package:drink_app_flutter/view/manage_drink_view.dart';
import 'package:drink_app_flutter/view/my_profile_view.dart';
import 'package:drink_app_flutter/view/register_view.dart';
import 'package:go_router/go_router.dart';

class DrinkAppRoutes {
  static const String homeView = '/home';
  static const String loginView = '/login';
  static const String registerView = '/register';
  static const String drinksView = '/drinks';
  static const String drinkDetailsView = '/drink_details/:id';
  static const String myDrinksView = '/my_drinks';
  static const String manageDrinkView = '/manage_drink';
  static const String myProfileView = '/my_profile';
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
        return DrinksView(ownDrinks: false);
      }
    ),
    GoRoute(
      path: DrinkAppRoutes.drinkDetailsView,
      name: DrinkAppRoutes.drinkDetailsView,
      builder: (context, state) {
        return DrinkDetailsView(drinkId: state.pathParameters['id']!);
      }
    ),
    GoRoute(
      path: DrinkAppRoutes.myDrinksView,
      name: DrinkAppRoutes.myDrinksView,
      builder: (context, state) {
        return DrinksView(ownDrinks: true);
      }
    ),
    GoRoute(
      path: DrinkAppRoutes.manageDrinkView,
      name: DrinkAppRoutes.manageDrinkView,
      builder: (context, state) {
        String? id = state.uri.queryParameters['id'];
        return ManageDrinkView(drinkId: id);
      }
    ),
    GoRoute(
      path: DrinkAppRoutes.myProfileView,
      name: DrinkAppRoutes.myProfileView,
      builder: (context, state) {
        return MyProfileView();
      }
    ),
  ]
);
