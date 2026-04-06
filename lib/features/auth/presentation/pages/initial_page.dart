import 'package:flutter/material.dart';
import 'package:gymio/core/routes/app_routes.dart';
import 'package:gymio/features/auth/presentation/widgets/primary_button.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              const Spacer(flex: 3),

              // Área do Logo (Ícone + Texto)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.bar_chart_rounded,
                    size: 60,
                    color: Color(0xFF007BFF),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'GYMIO',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF007BFF),
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 3),

              // Botão de Login
              PrimaryButton(
                label: 'Entrar',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),

              const SizedBox(height: 16),

              // Botão de Cadastro
              PrimaryButton(
                label: 'Cadastre-se',
                onPressed: () {
                  // Comando para navegar para a tela de cadastro
                  Navigator.pushNamed(context, AppRoutes.signup);
                },
              ),

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
