import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardViewModel extends ChangeNotifier {
  int selectedIndex = 0;

  User? user = Supabase.instance.client.auth.currentUser;
  late final StreamSubscription<AuthState> _authSubscription;

  DashboardViewModel() {
    _init();
  }

  void _init() {
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((
      data,
    ) {
      user = data.session?.user ?? Supabase.instance.client.auth.currentUser;
      notifyListeners();
    });
  }

  void changeTab(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}
