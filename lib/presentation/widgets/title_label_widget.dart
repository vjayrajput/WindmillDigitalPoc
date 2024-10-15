import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/core/resources/styles.dart';

class TitleLabel extends StatelessWidget {
  final String label;
  final TextAlign textAlign;

  const TitleLabel({
    super.key,
    required this.label,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTextStyles.titleStyle,
      textAlign: textAlign,
    );
  }
}
