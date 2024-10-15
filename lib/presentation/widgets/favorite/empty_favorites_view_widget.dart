import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/widgets/text_label_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/title_label_widget.dart';

class EmptyFavoritesView extends StatelessWidget {
  const EmptyFavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            const TitleLabel(label: Strings.noFavoritesYet),
            const SizedBox(height: 10),
            const TextLabel(
              label: Strings.startAddingYourItemHere,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
