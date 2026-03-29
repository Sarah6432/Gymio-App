import 'package:flutter/material.dart';
import 'package:gymio/core/routes/app_routes.dart';
import 'package:gymio/dashboard_page.dart';
import 'package:gymio/features/auth/presentation/pages/login_page.dart';
import 'package:gymio/features/auth/presentation/pages/signup_page.dart';
import 'package:gymio/initial_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.initial:
        return MaterialPageRoute(builder: (_) => const InitialPage());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const SignInPage());

      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());

      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());

      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(
                body: Center(child: Text('Rota não encontrada')),
              ),
        );
    }
  }
}
