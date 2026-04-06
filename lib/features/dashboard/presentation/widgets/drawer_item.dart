import 'package:flutter/material.dart';

class DashboardDrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;
  final Color? color;

  const DashboardDrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? (selected ? const Color(0xFF0059B3) : Colors.grey);

    return ListTile(
      leading: Icon(icon, color: effectiveColor),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? (selected ? const Color(0xFF0059B3) : Colors.black87),
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: selected,
      onTap: onTap,
    );
  }
}
