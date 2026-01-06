import 'package:flutter/material.dart';

class StatisticsContent extends StatelessWidget {
  const StatisticsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Frequência Semanal", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(width: 120, height: 120, child: CircularProgressIndicator(value: 0.75, strokeWidth: 10, backgroundColor: Colors.grey[200], color: const Color(0xFF0059B3))),
                const Text("75%", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text("Desempenho por Aula", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Container(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _bar("Seg", 0.4), _bar("Ter", 0.8), _bar("Qua", 0.2), _bar("Qui", 0.9), _bar("Sex", 0.6),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text("Resumo Geral", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const ListTile(leading: Icon(Icons.fitness_center), title: Text("Total de Aulas"), trailing: Text("12")),
          const ListTile(leading: Icon(Icons.local_fire_department), title: Text("Calorias"), trailing: Text("4.200 kcal")),
        ],
      ),
    );
  }

  Widget _bar(String d, double h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(width: 25, height: 100 * h, decoration: BoxDecoration(color: const Color(0xFF0059B3), borderRadius: BorderRadius.circular(5))),
        Text(d),
      ],
    );
  }
}