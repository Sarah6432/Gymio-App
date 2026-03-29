import 'package:flutter/material.dart';
import 'package:gymio/features/auth/presentation/pages/auth_gate.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gymio',
      theme: AppTheme.light,
      home: const AuthGate(),
    );
  }
}
