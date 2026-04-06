import 'package:flutter/material.dart';

class CalendarItem extends StatelessWidget {
  final String title;
  final String time;
  final Color color;

  const CalendarItem({
    super.key,
    required this.title,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(width: 5, color: color),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(time),
      trailing: const Icon(Icons.notifications_none),
    );
  }
}
