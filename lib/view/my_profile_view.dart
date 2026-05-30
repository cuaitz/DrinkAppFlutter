import 'package:drink_app_flutter/routes.dart';
import 'package:drink_app_flutter/view/default_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyProfileView extends StatefulWidget {
  const MyProfileView({super.key});

  @override
  State<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends State<MyProfileView> {
  // User? _user;

  // //! TO-DO: Fazer o fetch do user real aqui
  // Future<User> _getCurrentUser() async {
  //   await Future.delayed(Duration(seconds: 2)); //! TO-DO: TIRAR ISSO DEPOIS
  //   return User.getMockUser();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _getCurrentUser().then((user) {
  //     setState(() {
  //       _user = user;
  //     });
  //   });
  // }

  void _onLogout() {
    GoRouter.of(context).go(DrinkAppRoutes.homeView);
  }

  @override
  Widget build(BuildContext context) {
    //! TO-DO: Criar o model de user dnv
    return DefaultView(
      title: 'Loading Profile...',
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );

    // if (_user == null) {
    //   return DefaultView(
    //     title: 'Loading Profile...',
    //     body: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }

    // return DefaultView(
    //   title: 'My Profile',
    //   body: Center(
    //     child: Column(
    //       children: [
    //         Text("Name: ${_user!.name}", style: Theme.of(context).textTheme.titleMedium,),
    //         Text("Email: ${_user!.email}", style: Theme.of(context).textTheme.titleMedium),
    //         Text("Registered on: ${_user!.createdAt.toLocal()}", style: Theme.of(context).textTheme.bodyMedium),
    //         DrinkButton(
    //           text: 'Logout',
    //           onPressed: _onLogout
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}