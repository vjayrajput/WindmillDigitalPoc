import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/presentation/widgets/title_label_widget.dart';

class CryptoInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const CryptoInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          TitleLabel(label: label),
          const SizedBox(width: 8),
          Expanded(
            child: TitleLabel(label: value, textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }
}
