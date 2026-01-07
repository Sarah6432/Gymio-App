import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dashboard_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // 1. Controladores
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _birthDateController = TextEditingController();
  
  bool _isLoading = false;

  // 2. Função de Cadastro
  Future<void> _handleSignUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Validações básicas
    if (email.isEmpty || password.isEmpty) {
      _showError("Preencha todos os campos obrigatórios.");
      return;
    }

    if (password != confirmPassword) {
      _showError("As senhas não coincidem.");
      return;
    }

    if (password.length < 8) {
      _showError("A senha deve ter pelo menos 8 caracteres.");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final supabase = Supabase.instance.client;
      
      // Chamada de cadastro do Supabase
      await supabase.auth.signUp(
        email: email,
        password: password,
        // Você pode passar metadados como a data de nascimento
        data: {'birthdate': _birthDateController.text},
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cadastro realizado! Verifique seu e-mail.")),
        );
        // Opcional: Redirecionar para Dashboard se o Supabase não exigir confirmação de e-mail
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Cadastrar-se',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFieldLabel("Email"),
            _buildTextField(hint: "exemplo@exemplo.com", controller: _emailController),
            
            const SizedBox(height: 16),
            _buildFieldLabel("Data De Nascimento"),
            _buildTextField(hint: "03/16/1999", controller: _birthDateController),
            
            const SizedBox(height: 16),
            _buildFieldLabel("Senha"),
            _buildTextField(hint: "Senha", isPassword: true, controller: _passwordController),
            
            const SizedBox(height: 16),
            _buildFieldLabel("Confirmar Senha"),
            _buildTextField(hint: "Confirmar Senha", isPassword: true, controller: _confirmPasswordController),
            
            const SizedBox(height: 12),
            _buildPasswordRequirements(),
            
            const SizedBox(height: 32),
            _buildTermsText(),
            
            const SizedBox(height: 24),
            // Botão de Cadastro
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleSignUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0059B3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Concordar e continuar", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widgets Auxiliares ---

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey)),
    );
  }

  Widget _buildTextField({required String hint, bool isPassword = false, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        suffixIcon: isPassword ? const Icon(Icons.visibility_off_outlined, color: Colors.grey) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.grey)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.grey.shade300)),
      ),
    );
  }

  Widget _buildPasswordRequirements() {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "Senha deve ter pelo menos 8 caracteres, letras maiúsculas, minúsculas e caracteres especiais.",
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsText() {
    return Text(
      "Ao clicar no botão 'Concordar e continuar', você concorda com os Termos e Serviços da Gymio e reconhece a Política de Privacidade",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
    );
  }
}