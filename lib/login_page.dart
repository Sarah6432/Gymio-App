import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:gymio/dashboard_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signIn() async {
    setState(() => _isLoading = true);

    try {
      final supabase = Supabase.instance.client;
      
      await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
          (route) => false,
        );
      }
    } on AuthException catch (error) {
      _showErrorSnackBar(error.message);
    } catch (error) {
      _showErrorSnackBar('Ocorreu um erro inesperado');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
          'Entrar',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder( // Garante que o conteúdo possa ocupar a altura total
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight, // Ocupa a altura disponível do body
              ),
              child: IntrinsicHeight( // Ajusta o tamanho da Column ao conteúdo
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Centraliza verticalmente
                  crossAxisAlignment: CrossAxisAlignment.start, // Mantém labels alinhados à esquerda
                  children: [
                    const SizedBox(height: 20),
                    
                    _buildLabel("Email"),
                    _buildTextField(
                      hint: "exemplo@exemplo.com", 
                      controller: _emailController,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    _buildLabel("Senha"),
                    _buildTextField(
                      hint: "senha", 
                      isPassword: true, 
                      controller: _passwordController,
                    ),
                    
                    const SizedBox(height: 30),

                    // Botão Continue
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _signIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0059B3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                "Continue",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Esqueceu sua senha?", 
                          style: TextStyle(color: Colors.black54)
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text, 
        style: const TextStyle(
          fontSize: 14, 
          color: Colors.grey, 
          fontWeight: FontWeight.w500
        )
      ),
    );
  }

  Widget _buildTextField({
    required String hint, 
    bool isPassword = false, 
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        suffixIcon: isPassword
            ? const Icon(Icons.visibility_off_outlined, color: Colors.grey)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.black87),
        ),
      ),
    );
  }
}