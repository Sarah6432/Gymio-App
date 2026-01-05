import 'package:flutter/material.dart';

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
                    Icons.bar_chart_rounded, // Ícone que remete ao gráfico da imagem
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
              _buildButton(
                label: 'Login',
                onPressed: () {
                  // Ação de login
                },
              ),

              const SizedBox(height: 16),

              // Botão de Cadastro
              _buildButton(
                label: 'Cadastre-se',
                onPressed: () {
                  // Ação de cadastro
                },
              ),
              
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }

  // Helper para criar os botões idênticos
  Widget _buildButton({required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0059B3), // Azul mais escuro do botão
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}