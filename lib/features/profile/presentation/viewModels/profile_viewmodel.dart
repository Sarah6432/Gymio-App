import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileViewModel extends ChangeNotifier {
  final supabase = Supabase.instance.client;

  User? user = Supabase.instance.client.auth.currentUser;
  bool isLoading = false;

  String get userPhoto =>
      user?.userMetadata?['avatar_url'] ??
      "https://cdn-icons-png.flaticon.com/512/149/149071.png";

  String get userName => user?.userMetadata?['display_name'] ?? "";

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image == null) return;

    isLoading = true;
    notifyListeners();

    try {
      final file = File(image.path);
      final fileName = '${user!.id}/avatar.png';

      await supabase.storage
          .from('avatars')
          .upload(fileName, file, fileOptions: const FileOptions(upsert: true));

      final publicUrl = supabase.storage.from('avatars').getPublicUrl(fileName);

      await supabase.auth.updateUser(
        UserAttributes(data: {'avatar_url': publicUrl}),
      );

      // refresh user
      user = supabase.auth.currentUser;
    } catch (e) {
      rethrow;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfile(String name) async {
    isLoading = true;
    notifyListeners();

    try {
      await supabase.auth.updateUser(
        UserAttributes(data: {'display_name': name}),
      );

      user = supabase.auth.currentUser;
    } catch (e) {
      rethrow;
    }

    isLoading = false;
    notifyListeners();
  }
}
