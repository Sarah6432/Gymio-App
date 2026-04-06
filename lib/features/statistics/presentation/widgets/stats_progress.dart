import 'package:flutter/material.dart';

class StatsProgress extends StatelessWidget {
  final double value; // 0.0 - 1.0

  const StatsProgress({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final percent = (value * 100).toInt();

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: CircularProgressIndicator(
            value: value,
            strokeWidth: 10,
            backgroundColor: Colors.grey[200],
            color: const Color(0xFF0059B3),
          ),
        ),
        Text(
          "$percent%",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
