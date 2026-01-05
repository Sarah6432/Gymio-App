import 'package:flutter/material.dart';
import 'initial_page.dart'; // Certifique-se de que o caminho está correto

void main() {
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
      ),
      home: const InitialPage(),
    );
  }
}