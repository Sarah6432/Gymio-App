import 'package:flutter/material.dart';
import 'package:gymio/core/routes/app_router.dart';
import 'package:gymio/core/routes/app_routes.dart';
import 'package:gymio/core/theme/app_theme.dart';
import 'package:gymio/features/auth/presentation/pages/auth_gate.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gymio',
      theme: AppTheme.light,

      initialRoute: AppRoutes.initial,
      onGenerateRoute: AppRouter.generateRoute,

      home: const AuthGate(),
    );
  }
}
