import 'package:flutter/material.dart';

class MessageText extends StatelessWidget {
  final String message;
  final TextAlign textAlign;

  const MessageText({
    super.key,
    required this.message,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      textAlign: textAlign,
    );
  }
}
