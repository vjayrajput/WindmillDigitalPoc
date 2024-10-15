import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/cryptocurrency_list_view.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/empty_crypto_view_widget.dart';

class CryptoListSuccessBody extends StatelessWidget {
  final List<CryptocurrencyUiModel> cryptocurrencies;
  final ScrollController scrollController;
  final bool isLoadingMore;
  final Future<void> Function() onRefresh;

  const CryptoListSuccessBody({
    super.key,
    required this.cryptocurrencies,
    required this.scrollController,
    required this.isLoadingMore,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (cryptocurrencies.isNotEmpty) {
      return CryptocurrencyListView(
        cryptocurrencies: cryptocurrencies,
        scrollController: scrollController,
        isLoadingMore: isLoadingMore,
        onRefresh: onRefresh,
      );
    } else {
      return EmptyStateView(onRefresh: onRefresh);
    }
  }
}
