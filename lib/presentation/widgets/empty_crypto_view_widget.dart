import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';

class EmptyStateView extends StatelessWidget {
  final VoidCallback onRefresh;

  const EmptyStateView({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            Strings.oopsNoDataAvailable,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            Strings.countNotFindCrypto,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRefresh,
            child: const Text(Strings.refresh),
          ),
        ],
      ),
    );
  }
}
