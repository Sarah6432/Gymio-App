import 'package:flutter/material.dart';

class StatsSummaryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const StatsSummaryItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Text(value),
    );
  }
}
