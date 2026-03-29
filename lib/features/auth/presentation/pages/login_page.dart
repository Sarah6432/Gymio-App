import 'package:flutter/material.dart';
import 'package:gymio/core/services/auth_service.dart';
import 'package:gymio/dashboard_page.dart';
import 'package:gymio/features/auth/presentation/viewModels/auth_viewmodel.dart';
import 'package:gymio/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:gymio/features/auth/presentation/widgets/primary_button.dart';
import 'package:gymio/features/auth/presentation/widgets/social_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AuthViewmodel _viewModel;
  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _viewModel = AuthViewmodel(AuthService());

    _listener = () => setState(() {});

    _viewModel.addListener(_listener);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_listener);
    _viewModel.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final success = await _viewModel.signIn(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (success && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
        (route) => false,
      );
    } else if (_viewModel.errorMessage != null) {
      _showError(_viewModel.errorMessage!);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              const Text(
                "Entrar",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 40),

              AuthTextField(
                controller: _emailController,
                hint: "seunome@gmail.com",
              ),

              const SizedBox(height: 16),

              AuthTextField(
                controller: _passwordController,
                hint: "Adicione uma senha forte",
              ),

              const SizedBox(height: 30),

              PrimaryButton(
                label: "Entrar",
                isLoading: _viewModel.isLoading,
                onPressed: _viewModel.isLoading ? null : _handleLogin,
              ),

              const SizedBox(height: 12),

              SocialButton(
                label: "Entrar com o Google",
                onPressed: _viewModel.signInWithGoogle,
              ),

              const SizedBox(height: 20),

              TextButton(onPressed: () {}, child: Text("Esqueceu sua senha?")),
            ],
          ),
        ),
      ),
    );
  }
}
