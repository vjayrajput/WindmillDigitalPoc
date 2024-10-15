import 'package:flutter/material.dart';

class IconButtonAction extends StatelessWidget {
  final IconData iconData;
  final Color tintColor;
  final VoidCallback onAction;

  const IconButtonAction(
      {super.key,
      this.iconData = Icons.favorite_border,
      this.tintColor = Colors.black,
      required this.onAction});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        iconData,
        color: tintColor,
      ),
      onPressed: onAction,
    );
  }
}
