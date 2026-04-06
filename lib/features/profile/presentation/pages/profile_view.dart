import 'package:flutter/material.dart';
import 'package:gymio/features/profile/presentation/viewModels/profile_viewmodel.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final ProfileViewModel vm;
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    vm = ProfileViewModel();
    _nameController.text = vm.userName;
  }

  @override
  void dispose() {
    vm.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: vm,
      builder: (context, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              _avatar(),
              const SizedBox(height: 30),
              _field("Nome Completo", _nameController),
              _readOnly("E-mail", vm.user?.email ?? ""),
              const SizedBox(height: 20),
              _saveButton(context),
            ],
          ),
        );
      },
    );
  }

  Widget _avatar() {
    return Stack(
      children: [
        CircleAvatar(radius: 50, backgroundImage: NetworkImage(vm.userPhoto)),
        if (vm.isLoading)
          const Positioned.fill(child: CircularProgressIndicator()),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              try {
                await vm.pickAndUploadImage();
                _show("Foto atualizada!");
              } catch (e) {
                _show("Erro no upload", error: true);
              }
            },
            child: const CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xFF0059B3),
              child: Icon(Icons.camera_alt, size: 15, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _saveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed:
            vm.isLoading
                ? null
                : () async {
                  try {
                    await vm.updateProfile(_nameController.text.trim());
                    _show("Nome atualizado!");
                  } catch (e) {
                    _show("Erro ao salvar", error: true);
                  }
                },
        child: const Text("Salvar Alterações"),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget _readOnly(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: TextEditingController(text: value),
        enabled: false,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  void _show(String msg, {bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: error ? Colors.red : null),
    );
  }
}
