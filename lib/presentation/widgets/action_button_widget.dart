import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onAction;

  const ActionButton({super.key, required this.label, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onAction,
      child: Text(label),
    );
  }
}
