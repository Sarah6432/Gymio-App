import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _client = Supabase.instance.client;

  Future<void> signUp({
    required String name,
    required String email,
    required String birthDate,
    required String password,
    required String confirmPassword,
    String? avatar_url,
  }) async {
    await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'display_name': name,
        'birthdate': birthDate,
        'avatar_url': 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
      },
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.gymio://login-callback/',
    );
  }
}
