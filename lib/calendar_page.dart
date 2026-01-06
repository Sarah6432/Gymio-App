import 'package:flutter/material.dart';

class CalendarContent extends StatelessWidget {
  const CalendarContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                const Text("Janeiro 2026", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [Text("D"), Text("S"), Text("T"), Text("Q"), Text("Q"), Text("S"), Text("S")],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _day("4"), _day("5"), _day("6", sel: true), _day("7"), _day("8"), _day("9"), _day("10")
                  ],
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Align(alignment: Alignment.centerLeft, child: Text("Aulas de Hoje", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _item("Yoga Flow", "08:00", Colors.orange),
              _item("Crossfit", "10:30", Colors.redAccent),
              _item("Musculação", "17:00", const Color(0xFF0059B3)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _day(String d, {bool sel = false}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: sel ? const Color(0xFF0059B3) : Colors.transparent, shape: BoxShape.circle),
      child: Text(d, style: TextStyle(color: sel ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
    );
  }

  Widget _item(String t, String h, Color c) {
    return ListTile(
      leading: Container(width: 5, color: c),
      title: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(h),
      trailing: const Icon(Icons.notifications_none),
    );
  }
}