import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dashboard_page.dart';

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
  final _nameController = TextEditingController(); // Novo: Controller para o Nome

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
          'avatar_url': 'https://cdn-icons-png.flaticon.com/512/149/149071.png', // Foto padrão
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
                    child: const Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFF0059B3),
                      child: Icon(Icons.camera_alt, size: 18, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),

            _buildFieldLabel("Nome Completo"),
            _buildTextField(hint: "Ex: João Silva", controller: _nameController),
            
            const SizedBox(height: 16),
            _buildFieldLabel("Email"),
            _buildTextField(hint: "exemplo@email.com", controller: _emailController),
            
            const SizedBox(height: 16),
            _buildFieldLabel("Data de Nascimento"),
            _buildTextField(hint: "DD/MM/AAAA", controller: _birthDateController),
            
            const SizedBox(height: 16),
            _buildFieldLabel("Senha"),
            _buildTextField(hint: "********", isPassword: true, controller: _passwordController),
            
            const SizedBox(height: 16),
            _buildFieldLabel("Confirmar Senha"),
            _buildTextField(hint: "********", isPassword: true, controller: _confirmPasswordController),
            
            const SizedBox(height: 32),
            _buildPrimaryButton(
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

  // Widgets auxiliares (mesmos do seu código original)
  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 12.0),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 14)),
    );
  }

  Widget _buildTextField({required String hint, bool isPassword = false, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.black12)),
      ),
    );
  }

  Widget _buildPrimaryButton({required String label, VoidCallback? onPressed, bool isLoading = false}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0059B3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: isLoading 
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}