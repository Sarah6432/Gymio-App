import 'package:flutter/material.dart';
import 'package:gymio/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // 1. Importe o pacote

Future<void> main() async {
  // 2. Garanta que os bindings do Flutter estejam inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Inicialize o Supabase
  await Supabase.initialize(
    url: "https://hkxtuazmbysbpkvjezrd.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhreHR1YXptYnlzYnBrdmplenJkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc4MDg4MTIsImV4cCI6MjA4MzE2ODgxMn0.6_mBX9x7UZUkm1J3qXmVfGBPMhCRo6dxxtYYJ8kIvPQ",
  );

  runApp(const App());
}
