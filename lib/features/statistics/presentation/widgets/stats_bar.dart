import 'package:flutter/material.dart';

class StatsBar extends StatelessWidget {
  final String label;
  final double value;

  const StatsBar({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 25,
          height: 100 * value,
          decoration: BoxDecoration(
            color: const Color(0xFF0059B3),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
