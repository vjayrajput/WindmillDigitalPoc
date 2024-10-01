import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/core/resources/styles.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';

class CryptoListTile extends StatelessWidget {
  final CryptocurrencyUiModel crypto;

  const CryptoListTile({super.key, required this.crypto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppThemes.cardPadding,
      child: Card(
        elevation: AppThemes.cardElevation,
        child: ListTile(
          title: Text(
            crypto.name,
            style: AppTextStyles.titleStyle,
          ),
          subtitle: Text(
            "(${crypto.symbol})",
            style: AppTextStyles.subtitleStyle,
          ),
          onTap: () {
            Navigator.pushNamed(context, Strings.routeDetails,
                arguments: crypto);
          },
        ),
      ),
    );
  }
}
