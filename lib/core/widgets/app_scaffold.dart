import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router/app_router.dart';
import 'app_bottom_nav.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  const AppScaffold({super.key, required this.child});

  int _indexFromLocation(String location) {
    if (location.startsWith(AppRoutes.plan)) return 1;
    if (location.startsWith(AppRoutes.mood)) return 2;
    if (location.startsWith(AppRoutes.profile)) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _indexFromLocation(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        onTap: (i) {
          switch (i) {
            case 0:
              context.go(AppRoutes.home);
              break;
            case 1:
              context.go(AppRoutes.plan);
              break;
            case 2:
              context.go(AppRoutes.mood);
              break;
            case 3:
              context.go(AppRoutes.profile);
              break;
          }
        },
      ),
    );
  }
}
