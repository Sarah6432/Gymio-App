import 'package:flutter/material.dart';
import '../widgets/calendar_day.dart';
import '../widgets/calendar_item.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Text(
                  "Janeiro 2026",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("D"),
                    Text("S"),
                    Text("T"),
                    Text("Q"),
                    Text("Q"),
                    Text("S"),
                    Text("S"),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CalendarDay(day: "4"),
                    CalendarDay(day: "5"),
                    CalendarDay(day: "6", selected: true),
                    CalendarDay(day: "7"),
                    CalendarDay(day: "8"),
                    CalendarDay(day: "9"),
                    CalendarDay(day: "10"),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Aulas de Hoje",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: const [
              CalendarItem(
                title: "Yoga Flow",
                time: "08:00",
                color: Colors.orange,
              ),
              CalendarItem(
                title: "Crossfit",
                time: "10:30",
                color: Colors.redAccent,
              ),
              CalendarItem(
                title: "Musculação",
                time: "17:00",
                color: Color(0xFF0059B3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
