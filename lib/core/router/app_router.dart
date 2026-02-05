import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/core/widgets/app_scaffold.dart';
import 'package:test_task/features/dashboard/presentation/pages/home_page.dart';
import 'package:test_task/features/mood/presentation/pages/mood_page.dart';
import 'package:test_task/features/plan/pages/training_calendar_page.dart';

class AppRoutes {
  static const home = '/';
  static const plan = '/plan';
  static const mood = '/mood';
  static const profile = '/profile';
}

class AppRouter {
  static final _rootKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootKey,
    initialLocation: AppRoutes.home,
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (c, s) => const NoTransitionPage(child: HomePage()),
          ),
          GoRoute(
            path: AppRoutes.plan,
            pageBuilder: (c, s) =>
                const NoTransitionPage(child: TrainingCalendarPage()),
          ),
          GoRoute(
            path: AppRoutes.mood,
            pageBuilder: (c, s) => const NoTransitionPage(child: MoodPage()),
          ),
          GoRoute(
            path: AppRoutes.profile,
            pageBuilder: (c, s) =>
                const NoTransitionPage(child: Center(child: Text("Profile"))),
          ),
        ],
      ),
    ],
  );
}
