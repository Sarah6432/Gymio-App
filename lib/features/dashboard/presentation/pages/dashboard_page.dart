import 'package:flutter/material.dart';
import 'package:gymio/features/calendar/presentation/pages/calendar_page.dart';
import 'package:gymio/features/classes/presentation/pages/classes_view.dart';
import 'package:gymio/features/dashboard/presentation/viewModels/dashboard_viewmodel.dart';
import 'package:gymio/features/dashboard/presentation/widgets/drawer_item.dart';
import 'package:gymio/profile_page.dart';
import 'package:gymio/statistics_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final DashboardViewModel vm;

  final List<Widget> _pages = [
    const ClassesView(),
    const CalendarView(),
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
  void initState() {
    super.initState();
    vm = DashboardViewModel();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: vm,
      builder: (context, _) {
        final userName = vm.user?.userMetadata?['display_name'] ?? "Usuário";

        final userPhoto =
            vm.user?.userMetadata?['avatar_url'] ??
            "https://cdn-icons-png.flaticon.com/512/149/149071.png";

        return Scaffold(
          appBar: AppBar(title: Text(_titles[vm.selectedIndex])),
          drawer: Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(userName),
                  accountEmail: Text(vm.user?.email ?? ""),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(userPhoto),
                  ),
                ),
                _navItem(Icons.home, "Início", 0),
                _navItem(Icons.calendar_month, "Agenda", 1),
                _navItem(Icons.bar_chart, "Estatísticas", 2),
                _navItem(Icons.person, "Perfil", 3),
                const Spacer(),
                const Divider(),
                _navItem(Icons.logout, "Sair", -1),
              ],
            ),
          ),
          body: _pages[vm.selectedIndex],
        );
      },
    );
  }

  Widget _navItem(IconData icon, String title, int index) {
    return DashboardDrawerItem(
      icon: icon,
      title: title,
      selected: vm.selectedIndex == index,
      onTap: () {
        vm.changeTab(index);
        Navigator.pop(context);
      },
    );
  }
}
