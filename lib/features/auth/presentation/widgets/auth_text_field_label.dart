import 'package:flutter/material.dart';

class AuthTextFieldLabel extends StatelessWidget {
  final String label;

  const AuthTextFieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 12.0),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }
}
