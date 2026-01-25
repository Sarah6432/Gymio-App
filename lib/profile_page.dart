import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import necessário
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  final User? _user = Supabase.instance.client.auth.currentUser;
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = _user?.userMetadata?['display_name'] ?? "";
  }

  // --- FUNÇÃO PARA PEGAR FOTO E FAZER UPLOAD ---
  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    // 1. Seleciona a imagem da galeria
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image == null) return; // Usuário cancelou

    setState(() => _isLoading = true);

    try {
      final supabase = Supabase.instance.client;
      final file = File(image.path);
      final fileName = '${_user!.id}/avatar.png'; // Caminho único por usuário

      // 2. Faz o Upload para o Storage (balde chamado 'avatars')
      // Nota: Você precisa criar um bucket chamado 'avatars' no seu painel Supabase
      await supabase.storage.from('avatars').upload(
            fileName,
            file,
            fileOptions: const FileOptions(upsert: true), // Substitui se já existir
          );

      // 3. Pega a URL pública da foto
      final String publicUrl = supabase.storage.from('avatars').getPublicUrl(fileName);

      // 4. Atualiza os metadados do usuário com a nova URL
      await supabase.auth.updateUser(
        UserAttributes(data: {'avatar_url': publicUrl}),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Foto atualizada!")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erro no upload: $e"), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _updateProfile() async {
    setState(() => _isLoading = true);
    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(data: {'display_name': _nameController.text.trim()}),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Nome atualizado!")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Erro ao salvar"), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String userPhoto = _user?.userMetadata?['avatar_url'] ?? "https://cdn-icons-png.flaticon.com/512/149/149071.png";

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: NetworkImage(userPhoto),
                ),
                if (_isLoading)
                  const Positioned.fill(child: CircularProgressIndicator()), // Loader sobre a foto
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickAndUploadImage, // AGORA CHAMA A FUNÇÃO
                    child: const CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0xFF0059B3),
                      child: Icon(Icons.camera_alt, size: 15, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _buildField("Nome Completo", _nameController, Icons.person_outline),
          _buildReadOnlyField("E-mail", _user?.email ?? "Não informado", Icons.email_outlined),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _updateProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0059B3),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Salvar Alterações", style: TextStyle(color: Colors.white)),
            ),
          ),
          const SizedBox(height: 30),
          const Divider(),
          _opt(Icons.notifications, "Notificações"),
          _opt(Icons.lock, "Segurança"),
        ],
      ),
    );
  }

  Widget _buildField(String l, TextEditingController c, IconData i) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(controller: c, decoration: InputDecoration(labelText: l, prefixIcon: Icon(i))),
    );
  }

  Widget _buildReadOnlyField(String l, String v, IconData i) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(controller: TextEditingController(text: v), enabled: false, decoration: InputDecoration(labelText: l, prefixIcon: Icon(i), filled: true, fillColor: Colors.grey[50])),
    );
  }

  Widget _opt(IconData i, String t) {
    return ListTile(leading: Icon(i), title: Text(t), trailing: const Icon(Icons.chevron_right));
  }
}