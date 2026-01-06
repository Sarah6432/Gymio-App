import 'package:flutter/material.dart';
import 'calendar_page.dart';
import 'statistics_page.dart';
import 'profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

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
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF0059B3)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Color(0xFF0059B3)),
              ),
              accountName: Text("Alex Johnson"),
              accountEmail: Text("alex.j@exemplo.com"),
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

  Widget _buildDrawerItem(
    IconData icon,
    String title,
    int index, {
    Color? color,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color:
            color ??
            (_selectedIndex == index ? const Color(0xFF0059B3) : Colors.grey),
      ),
      title: Text(
        title,
        style: TextStyle(
          color:
              color ??
              (_selectedIndex == index
                  ? const Color(0xFF0059B3)
                  : Colors.black87),
          fontWeight:
              _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: _selectedIndex == index,
      onTap: () {
        if (index == -1) {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
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
        children: [
          const Text(
            'Continue o\nbom trabalho!',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar treinos...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Para Você',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          _card(
            'Treino de Superior',
            '12 Exercícios | 40 Min',
            const Color(0xFF0059B3),
          ),
          const SizedBox(height: 15),
          _card(
            'Treino de Inferior',
            '10 Exercícios | 35 Min',
            Colors.blueAccent,
          ),
        ],
      ),
    );
  }

  Widget _card(String t, String s, Color c) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(s, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: c,
            ),
            child: const Text('Começar'),
          ),
        ],
      ),
    );
  }
}
