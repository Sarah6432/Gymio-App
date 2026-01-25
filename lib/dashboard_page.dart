import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'calendar_page.dart';
import 'statistics_page.dart';
import 'profile_page.dart';
import 'initial_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  
  User? _user = Supabase.instance.client.auth.currentUser;
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      if (mounted) {
        setState(() {
          _user = data.session?.user ?? Supabase.instance.client.auth.currentUser;
        });
      }
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  final List<Widget> _pages = [
    const MainDashboardContent(),
    const CalendarContent(),
    const StatisticsContent(),
    const ProfileContent(),
  ];

  // Títulos da AppBar em Português
  final List<String> _titles = [
    'Gymio',
    'Agenda de Aulas',
    'Minhas Estatísticas',
    'Meu Perfil',
  ];

  @override
  Widget build(BuildContext context) {
    final String userName = _user?.userMetadata?['display_name'] ?? "Usuário";
    final String userPhoto = _user?.userMetadata?['avatar_url'] ?? 
        "https://cdn-icons-png.flaticon.com/512/149/149071.png";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey[200],
              backgroundImage: NetworkImage(userPhoto),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF0059B3)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(userPhoto),
              ),
              accountName: Text(
                userName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text(_user?.email ?? ""),
            ),
            _buildDrawerItem(Icons.home_filled, "Início", 0),
            _buildDrawerItem(Icons.calendar_month, "Agenda", 1),
            _buildDrawerItem(Icons.bar_chart, "Estatísticas", 2),
            _buildDrawerItem(Icons.person_outline, "Perfil", 3),
            const Spacer(),
            const Divider(),
            _buildDrawerItem(Icons.logout, "Sair", -1, color: Colors.red),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index, {Color? color}) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? (_selectedIndex == index ? const Color(0xFF0059B3) : Colors.grey),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? (_selectedIndex == index ? const Color(0xFF0059B3) : Colors.black87),
          fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: _selectedIndex == index,
      onTap: () async {
        if (index == -1) {
          await Supabase.instance.client.auth.signOut();
          if (mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const InitialPage()),
              (route) => false,
            );
          }
        } else {
          setState(() => _selectedIndex = index);
          Navigator.pop(context);
        }
      },
    );
  }
}

class MainDashboardContent extends StatelessWidget {
  const MainDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Continue com o\nbom trabalho!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 25),
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar seus treinos...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 35),
          const Center(
            child: Text(
              'Para Você',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          _card(
            'Treino de Membros Superiores', 
            '12 Exercícios | 40 Min', 
            const Color(0xFF0059B3)
          ),
          const SizedBox(height: 20),
          _card(
            'Treino de Membros Inferiores', 
            '10 Exercícios | 35 Min', 
            const Color(0xFF4A90FF)
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _card(String title, String subtitle, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, 
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 5),
          Text(
            subtitle, 
            style: const TextStyle(color: Colors.white70, fontSize: 16)
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: color,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('Começar', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}