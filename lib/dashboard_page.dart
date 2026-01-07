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

  // Pegando os dados do usuário atual do Supabase
  final User? _user = Supabase.instance.client.auth.currentUser;

  final List<Widget> _pages = [
    const MainDashboardContent(),
    const CalendarContent(),
    const StatisticsContent(),
    const ProfileContent(),
  ];

  final List<String> _titles = [
    'Gymio',
    'Agenda de Aulas',
    'Minhas Estatísticas',
    'Meu Perfil',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          // Ícone de perfil no topo como na foto
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, color: Colors.white),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF0059B3)),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Color(0xFF0059B3)),
              ),
              // Exibe o email real do usuário logado
              accountName: const Text("Bem-vindo(a)"),
              accountEmail: Text(_user?.email ?? "usuario@exemplo.com"),
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
          // Lógica de Sair corrigida com Supabase
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
        crossAxisAlignment: CrossAxisAlignment.start, // Alinhado à esquerda
        children: [
          const SizedBox(height: 10),
          const Text(
            'Keep on the\ngood work!',
            textAlign: TextAlign.center, // Centralizado como na foto
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          // Barra de busca estilizada
          TextField(
            decoration: InputDecoration(
              hintText: 'Search your programs...',
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
              'For You',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          _card(
            'Upper Body Workout',
            '12 Exercises | 40 Min',
            const Color(0xFF0059B3),
          ),
          const SizedBox(height: 20),
          _card(
            'Lower Body Workout',
            '10 Exercises | 35 Min',
            const Color(0xFF4A90FF), // Azul mais claro como o da foto
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _card(String title, String subtitle, Color color) {
    return Container(
      width: double.infinity, // Ocupa a largura toda
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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            ),
            child: const Text(
              'Start',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}