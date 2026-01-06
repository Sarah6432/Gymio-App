import 'package:flutter/material.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(radius: 50, backgroundColor: Colors.grey[200], child: const Icon(Icons.person, size: 50)),
                Positioned(bottom: 0, right: 0, child: CircleAvatar(radius: 15, backgroundColor: const Color(0xFF0059B3), child: const Icon(Icons.camera_alt, size: 15, color: Colors.white))),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _field("Nome Completo", "Alex Johnson"),
          _field("E-mail", "alex.j@exemplo.com"),
          const SizedBox(height: 30),
          _opt(Icons.notifications, "Notificações"),
          _opt(Icons.lock, "Segurança"),
          _opt(Icons.help, "Central de Ajuda"),
        ],
      ),
    );
  }

  Widget _field(String l, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(decoration: InputDecoration(labelText: l, border: const UnderlineInputBorder())),
    );
  }

  Widget _opt(IconData i, String t) {
    return ListTile(leading: Icon(i), title: Text(t), trailing: const Icon(Icons.chevron_right));
  }
}