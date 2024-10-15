import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/widgets/action_button_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/message_text_widget.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MessageText(message: message, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          ActionButton(label: Strings.retry, onAction: onRetry),
        ],
      ),
    );
  }
}
