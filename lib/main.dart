import 'package:flutter/material.dart';
import 'package:gymio/dashboard_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // 1. Importe o pacote
import 'initial_page.dart';

Future<void> main() async {
  // 2. Garanta que os bindings do Flutter estejam inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Inicialize o Supabase
  await Supabase.initialize(
    url: "https://hkxtuazmbysbpkvjezrd.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhreHR1YXptYnlzYnBrdmplenJkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc4MDg4MTIsImV4cCI6MjA4MzE2ODgxMn0.6_mBX9x7UZUkm1J3qXmVfGBPMhCRo6dxxtYYJ8kIvPQ",
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gymio',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF007BFF),
        // Dica: Defina a cor primária no colorScheme para o Material 3
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0059B3)),
      ),
      home:
          Supabase.instance.client.auth.currentSession != null
              ? const DashboardPage()
              : const InitialPage(),
    );
  }
}
