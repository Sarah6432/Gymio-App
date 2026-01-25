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
      _navigateToDashboard();
    } on AuthException catch (error) {
      _showErrorSnackBar(error.message);
    } catch (error) {
      _showErrorSnackBar('Ocorreu um erro inesperado');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.gymio://login-callback/', 
      );
    } on AuthException catch (error) {
      _showErrorSnackBar(error.message);
    } catch (error) {
      _showErrorSnackBar('Erro ao conectar com Google');
    }
  }

  void _navigateToDashboard() {
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
        (route) => false,
      );
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
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  // Centraliza os itens que não têm largura total (como o texto)
                  crossAxisAlignment: CrossAxisAlignment.stretch, 
                  children: [
                    const SizedBox(height: 50), 
                    
                    // TITULO CENTRALIZADO
                    const Text(
                      'Entrar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black, 
                        fontSize: 28, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 40),

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
                    
                    _buildPrimaryButton(
                      label: "Continue",
                      onPressed: _isLoading ? null : _signIn,
                      isLoading: _isLoading,
                    ),

                    const SizedBox(height: 10),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Esqueceu sua senha?",
                            style: TextStyle(color: Colors.black54)),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("ou", style: TextStyle(color: Colors.grey)),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                    ),

                    _buildSocialButton(
                      label: "Entrar com Google",
                      onPressed: _signInWithGoogle,
                    ),
                    
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
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
          elevation: 0,
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

  Widget _buildSocialButton({required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          side: const BorderSide(color: Colors.black12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
              height: 22,
            ),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8),
      child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTextField({required String hint, bool isPassword = false, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.black12),
        ),
      ),
    );
  }
}