import 'package:flutter/material.dart';
import 'package:gymio/core/services/auth_service.dart';
import 'package:gymio/features/auth/presentation/viewModels/auth_viewmodel.dart';
import 'package:gymio/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:gymio/features/auth/presentation/widgets/auth_text_field_label.dart';
import 'package:gymio/features/auth/presentation/widgets/avatar_picker.dart';
import 'package:gymio/features/auth/presentation/widgets/primary_button.dart';
import '../../../../dashboard_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _nameController =
      TextEditingController(); // Novo: Controller para o Nome

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
    _confirmPasswordController.dispose();
    _birthDateController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final success = await _viewModel.signUp(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
      _confirmPasswordController.text.trim(),
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cadastro realizado com sucesso!")),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
        (route) => false,
      );
    } else if (_viewModel.errorMessage != null) {
      _showError(_viewModel.errorMessage!);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Criar Conta',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            AvatarPicker(), //TODO passar função de onTap com Supabase depois

            const SizedBox(height: 30),

            AuthTextFieldLabel(label: "Nome Completo"),
            AuthTextField(hint: "Ex: João Silva", controller: _nameController),

            const SizedBox(height: 16),
            AuthTextFieldLabel(label: "Email"),
            AuthTextField(
              hint: "exemplo@email.com",
              controller: _emailController,
            ),

            const SizedBox(height: 16),
            AuthTextFieldLabel(label: "Data de Nascimento"),
            AuthTextField(hint: "DD/MM/AAAA", controller: _birthDateController),

            const SizedBox(height: 16),
            AuthTextFieldLabel(label: "Senha"),
            AuthTextField(
              hint: "********",
              isPassword: true,
              controller: _passwordController,
            ),

            const SizedBox(height: 16),
            AuthTextFieldLabel(label: "Confirmar Senha"),
            AuthTextField(
              hint: "********",
              isPassword: true,
              controller: _confirmPasswordController,
            ),

            const SizedBox(height: 32),
            PrimaryButton(
              label: "Cadastrar",
              onPressed: _viewModel.isLoading ? null : _handleSignUp,
              isLoading: _viewModel.isLoading,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
