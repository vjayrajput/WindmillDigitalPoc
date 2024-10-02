import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/core/resources/styles.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';

class CryptoDetailsCard extends StatelessWidget {
  final CryptocurrencyUiModel cryptocurrency;

  const CryptoDetailsCard({super.key, required this.cryptocurrency});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppThemes.cardElevation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "${Strings.cryptocurrencyId}${cryptocurrency.id}",
              style: AppTextStyles.titleStyle,
            ),
            Text(
              "${Strings.name}${cryptocurrency.name}",
              style: AppTextStyles.titleStyle,
            ),
            Text(
              "${Strings.symbol}${cryptocurrency.symbol}",
              style: AppTextStyles.titleStyle,
            ),
            Text(
              "${Strings.rank}${cryptocurrency.rank}",
              style: AppTextStyles.titleStyle,
            ),
            Text(
              "${Strings.firstHistoricalData}${cryptocurrency.firstHistoricalData}",
              style: AppTextStyles.titleStyle,
            ),
            Text(
              "${Strings.lastHistoricalData}${cryptocurrency.lastHistoricalData}",
              style: AppTextStyles.titleStyle,
            ),
          ],
        ),
      ),
    );
  }
}
