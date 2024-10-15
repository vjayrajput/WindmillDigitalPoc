import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/core/resources/styles.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/widgets/details/crypto_details_card_widget.dart';

class CryptocurrencyDetailBody extends StatelessWidget {
  final CryptocurrencyUiModel? cryptocurrency;

  const CryptocurrencyDetailBody({super.key, required this.cryptocurrency});

  @override
  Widget build(BuildContext context) {
    if (cryptocurrency == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: AppThemes.cardPadding,
      child: CryptoDetailsCard(cryptocurrency: cryptocurrency!),
    );
  }
}
