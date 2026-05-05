import 'package:drink_app_flutter/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrinkBottomAppBar extends StatelessWidget {
  const DrinkBottomAppBar({super.key});

  Widget _buildItem(IconData icon, String label, void Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 90,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildItem(Icons.local_drink_outlined, 'Cocktails', () {
            GoRouter.of(context).go(DrinkAppRoutes.drinksView);
          }),
          _buildItem(Icons.water_drop_outlined, 'My Drinks', () {
            GoRouter.of(context).go(DrinkAppRoutes.myDrinksView);
          }),
          _buildItem(Icons.person_outline, 'Profile', () {
            GoRouter.of(context).go(DrinkAppRoutes.myProfileView);
          })
        ],
      )
    );
  }
}