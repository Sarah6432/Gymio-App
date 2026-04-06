import 'package:flutter/material.dart';
import '../../data/models/classes_model.dart';

class ClassCard extends StatelessWidget {
  final AulaModel aula;
  final int index;

  const ClassCard({super.key, required this.aula, required this.index});

  static const _colors = [Color(0xFF0059B3), Color(0xFF4A90FF)];

  @override
  Widget build(BuildContext context) {
    final color = _colors[index % _colors.length];

    final subtitle =
        '${aula.instrutor} · ${aula.diaSemana} ${aula.horario} · '
        '${aula.alunosInscritos}/${aula.capacidade}';

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            aula.nome,
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
            ),
            child: const Text('Começar'),
          ),
        ],
      ),
    );
  }
}
