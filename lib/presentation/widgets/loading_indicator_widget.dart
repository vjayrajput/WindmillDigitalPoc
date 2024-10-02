import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.bottomCenter,
      child: const SizedBox(
        height: 54,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
