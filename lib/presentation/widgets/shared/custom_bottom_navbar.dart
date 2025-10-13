import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavbar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomBottomNavbar({super.key, required this.navigationShell});

  // int _getCurrentIndex(BuildContext context) {
  //   final String location = GoRouterState.of(context).matchedLocation;

  //   switch (location) {
  //     case '/':
  //       return 0;
  //     case '/categories':
  //       return 1;
  //     case '/favorites':
  //       return 2;
  //     default:
  //       return 0;
  //   }
  // }

  // void _onTap(BuildContext context, int value) {
  //   switch (value) {
  //     case 0:
  //       context.go('/');
  //       break;
  //     case 1:
  //       context.go('/categories');
  //       break;
  //     case 2:
  //       context.go('/favorites');
  //       break;
  //   }
  // }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      currentIndex: navigationShell.currentIndex,
      onTap: (index) => _onTap(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: "Home"),
        BottomNavigationBarItem(
          icon: Icon(Icons.label_outline),
          label: "Categories",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_outline),
          label: "Favorites",
        ),
      ],
    );
  }
}
