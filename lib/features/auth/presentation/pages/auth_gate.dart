import 'package:flutter/material.dart';
import 'package:gymio/dashboard_page.dart';
import 'package:gymio/initial_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = Supabase.instance.client.auth.currentSession;

        if (session != null) {
          return const DashboardPage();
        } else {
          return const InitialPage();
        }
      },
    );
  }
}
