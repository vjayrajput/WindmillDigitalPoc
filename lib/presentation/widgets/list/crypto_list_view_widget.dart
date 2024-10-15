import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/crypto_list_tile_widget.dart';

class CryptoListView extends StatelessWidget {
  final List<CryptocurrencyUiModel> cryptocurrencies;
  final ScrollController scrollController;

  const CryptoListView({
    super.key,
    required this.cryptocurrencies,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: cryptocurrencies.length,
      itemBuilder: (context, index) {
        final crypto = cryptocurrencies[index];
        return CryptoListTile(crypto: crypto);
      },
    );
  }
}
