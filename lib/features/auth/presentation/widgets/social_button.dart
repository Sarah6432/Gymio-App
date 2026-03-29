import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const SocialButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: OutlinedButton(onPressed: onPressed, child: Text(label)),
    );
  }
}
