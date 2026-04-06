import 'package:flutter/material.dart';
import 'package:gymio/features/classes/presentation/viewModels/classes_viewmodel.dart';
import 'package:gymio/features/classes/presentation/widgets/class_card.dart';

class ClassesView extends StatefulWidget {
  const ClassesView({super.key});

  @override
  State<ClassesView> createState() => _ClassesViewState();
}

class _ClassesViewState extends State<ClassesView> {
  late final ClassesViewmodel vm;

  @override
  void initState() {
    super.initState();
    vm = ClassesViewmodel();
    vm.load();
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
        return RefreshIndicator(onRefresh: vm.load, child: _buildContent());
      },
    );
  }

  Widget _buildContent() {
    if (vm.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (vm.error != null) {
      return ListView(
        children: [
          const SizedBox(height: 100),
          Center(
            child: Text(vm.error!, style: const TextStyle(color: Colors.red)),
          ),
        ],
      );
    }

    if (vm.aulas.isEmpty) {
      return ListView(
        children: const [
          SizedBox(height: 100),
          Center(
            child: Text(
              'Nenhuma aula cadastrada ainda.',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: vm.aulas.length,
      itemBuilder: (context, index) {
        final aula = vm.aulas[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ClassCard(aula: aula, index: index),
        );
      },
    );
  }
}
