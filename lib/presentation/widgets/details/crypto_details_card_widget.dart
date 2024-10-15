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
              key: const ValueKey('cryptoIdRow'),
              label: Strings.cryptocurrencyId,
              value: cryptocurrency.id.toString(),
            ),
            CryptoInfoRow(
              key: const ValueKey('cryptoNameRow'),
              label: Strings.name,
              value: cryptocurrency.name,
            ),
            CryptoInfoRow(
              key: const ValueKey('cryptoSymbolRow'),
              label: Strings.symbol,
              value: cryptocurrency.symbol,
            ),
            CryptoInfoRow(
              key: const ValueKey('cryptoRankRow'),
              label: Strings.rank,
              value: cryptocurrency.rank.toString(),
            ),
            CryptoInfoRow(
              key: const ValueKey('cryptoFirstHistoricalDataRow'),
              label: Strings.firstHistoricalData,
              value: cryptocurrency.firstHistoricalData,
            ),
            CryptoInfoRow(
              key: const ValueKey('cryptoLastHistoricalDataRow'),
              label: Strings.lastHistoricalData,
              value: cryptocurrency.lastHistoricalData,
            ),
          ],
        ),
      ),
    );
  }
}
