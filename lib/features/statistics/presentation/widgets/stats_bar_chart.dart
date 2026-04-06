import 'package:flutter/material.dart';
import 'stats_bar.dart';

class StatsBarChart extends StatelessWidget {
  final Map<String, double> data;

  const StatsBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children:
            data.entries
                .map((e) => StatsBar(label: e.key, value: e.value))
                .toList(),
      ),
    );
  }
}
