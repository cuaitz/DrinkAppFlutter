import 'package:drink_app_flutter/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrinkBottomAppBar extends StatelessWidget {
  const DrinkBottomAppBar({super.key});

  Widget _buildItem(BuildContext context, IconData icon, String label, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            _buildItem(context, Icons.local_drink_outlined, 'Coquetéis', () {
            GoRouter.of(context).go(DrinkAppRoutes.drinksView);
          }),
          _buildItem(context, Icons.water_drop_outlined, 'Meus drinks', () {
            GoRouter.of(context).go(DrinkAppRoutes.myDrinksView);
          }),
          _buildItem(context, Icons.person_outline, 'Perfil', () {
            GoRouter.of(context).go(DrinkAppRoutes.myProfileView);
          })
        ],
      )
    );
  }
}