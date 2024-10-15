import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/core/resources/styles.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/widgets/details/crypto_info_row_widget.dart';

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
            CryptoInfoRow(
              label: Strings.cryptocurrencyId,
              value: cryptocurrency.id.toString(),
            ),
            CryptoInfoRow(
              label: Strings.name,
              value: cryptocurrency.name,
            ),
            CryptoInfoRow(
              label: Strings.symbol,
              value: cryptocurrency.symbol,
            ),
            CryptoInfoRow(
              label: Strings.rank,
              value: cryptocurrency.rank.toString(),
            ),
            CryptoInfoRow(
              label: Strings.firstHistoricalData,
              value: cryptocurrency.firstHistoricalData,
            ),
            CryptoInfoRow(
              label: Strings.lastHistoricalData,
              value: cryptocurrency.lastHistoricalData,
            ),
          ],
        ),
      ),
    );
  }
}
