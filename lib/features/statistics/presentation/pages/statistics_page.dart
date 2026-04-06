import 'package:flutter/material.dart';
import '../widgets/stats_progress.dart';
import '../widgets/stats_bar_chart.dart';
import '../widgets/stats_summary_item.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Frequência Semanal",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Center(child: StatsProgress(value: 0.75)),
          const SizedBox(height: 40),
          const Text(
            "Desempenho por Aula",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const StatsBarChart(
            data: {"Seg": 0.4, "Ter": 0.8, "Qua": 0.2, "Qui": 0.9, "Sex": 0.6},
          ),
          const SizedBox(height: 30),
          const Text(
            "Resumo Geral",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const StatsSummaryItem(
            icon: Icons.fitness_center,
            title: "Total de Aulas",
            value: "12",
          ),
          const StatsSummaryItem(
            icon: Icons.local_fire_department,
            title: "Calorias",
            value: "4.200 kcal",
          ),
        ],
      ),
    );
  }
}
