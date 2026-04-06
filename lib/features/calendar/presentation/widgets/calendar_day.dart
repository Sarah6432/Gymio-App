import 'package:flutter/material.dart';

class CalendarDay extends StatelessWidget {
  final String day;
  final bool selected;

  const CalendarDay({super.key, required this.day, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF0059B3) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Text(
        day,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
