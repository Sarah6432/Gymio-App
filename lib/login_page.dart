import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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
          'Sign In',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            
            _buildLabel("Email"),
            _buildTextField(hint: "example@example.com"),
            
            const SizedBox(height: 20),
            
            _buildLabel("Password"),
            _buildTextField(hint: "Password", isPassword: true),
            
            const SizedBox(height: 30),
            
            // Botão Continue
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0059B3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                ),
                child: const Text("Continue", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text("Forgot Password?", style: TextStyle(color: Colors.black54)),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Divisor "or"
            Row(
              children: [
                const Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text("or", style: TextStyle(color: Colors.grey[600])),
                ),
                const Expanded(child: Divider(thickness: 1)),
              ],
            ),
            
            const SizedBox(height: 30),
            
            // Botões Sociais
            _buildSocialButton(
              label: "Continue with Google",
              iconPath: Icons.g_mobiledata, // Substitua por imagem real se tiver
              onPressed: () {},
            ),
            
            const SizedBox(height: 15),
            
            _buildSocialButton(
              label: "Continue with Facebook",
              iconPath: Icons.facebook,
              iconColor: Colors.blue,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(text, style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTextField({required String hint, bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        suffixIcon: isPassword ? const Icon(Icons.visibility_off_outlined, color: Colors.grey) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.black)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Colors.black87)),
      ),
    );
  }

  Widget _buildSocialButton({required String label, required IconData iconPath, Color? iconColor, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(iconPath, color: iconColor ?? Colors.red, size: 28),
        label: Text(label, style: const TextStyle(color: Colors.black, fontSize: 15)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black87),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}