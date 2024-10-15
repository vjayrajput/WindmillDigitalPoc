import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/crypto_list_view_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/loading_indicator_widget.dart';

class CryptocurrencyListView extends StatelessWidget {
  final List<CryptocurrencyUiModel> cryptocurrencies;
  final ScrollController scrollController;
  final bool isLoadingMore;
  final Future<void> Function() onRefresh;

  const CryptocurrencyListView({
    super.key,
    required this.cryptocurrencies,
    required this.scrollController,
    required this.isLoadingMore,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: onRefresh,
          child: CryptoListView(
            cryptocurrencies: cryptocurrencies,
            scrollController: scrollController,
          ),
        ),
        if (isLoadingMore) const LoadingIndicator(),
      ],
    );
  }
}
