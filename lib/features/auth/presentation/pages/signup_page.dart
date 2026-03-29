import 'package:flutter/material.dart';
import 'package:gymio/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:gymio/features/auth/presentation/widgets/auth_text_field_label.dart';
import 'package:gymio/features/auth/presentation/widgets/primary_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

  bool _isLoading = false;

  Future<void> _handleSignUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final name = _nameController.text.trim();

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      _showError("Preencha todos os campos obrigatórios.");
      return;
    }

    if (password != confirmPassword) {
      _showError("As senhas não coincidem.");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final supabase = Supabase.instance.client;

      // Realiza o cadastro enviando o nome e uma foto padrão nos metadados
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'display_name': name,
          'birthdate': _birthDateController.text,
          'avatar_url':
              'https://cdn-icons-png.flaticon.com/512/149/149071.png', // Foto padrão
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cadastro realizado com sucesso!")),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
          (route) => false,
        );
      }
    } on AuthException catch (error) {
      _showError(error.message);
    } catch (error) {
      _showError("Ocorreu um erro inesperado.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
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

            // Avatar Placeholder
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFF0059B3),
                      child: Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
              onPressed: _isLoading ? null : _handleSignUp,
              isLoading: _isLoading,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
