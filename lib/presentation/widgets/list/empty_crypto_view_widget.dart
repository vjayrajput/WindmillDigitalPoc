import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/widgets/action_button_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/text_label_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/title_label_widget.dart';

class EmptyStateView extends StatelessWidget {
  final VoidCallback onRefresh;

  const EmptyStateView({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TitleLabel(label: Strings.oopsNoDataAvailable),
          const SizedBox(height: 16),
          const TextLabel(
              label: Strings.countNotFindCrypto, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ActionButton(label: Strings.refresh, onAction: onRefresh),
        ],
      ),
    );
  }
}
