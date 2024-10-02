import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_state.dart';
import 'package:windmill_digital_poc/presentation/widgets/crypto_list_view_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/empty_crypto_view_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/error_view_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/loading_indicator_widget.dart';

class CryptocurrenciesPage extends StatefulWidget {
  const CryptocurrenciesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CryptocurrenciesPageState();
  }
}

class _CryptocurrenciesPageState extends State<CryptocurrenciesPage> {
  final _scrollController = ScrollController();
  int _page = 1;
  final int _limit = 20;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadCryptocurrencies();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _page++;
      _loadCryptocurrencies();
    }
  }

  Future<void> _loadCryptocurrencies({bool isRefresh = false}) async {
    if (isRefresh) {
      _page = 1;
    }
    context
        .read<CryptocurrencyBloc>()
        .add(LoadCryptocurrencies(page: _page, limit: _limit));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptocurrencyBloc, CryptocurrencyState>(
      builder: (context, state) {
        if (state is CryptocurrencyLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CryptocurrencyLoaded) {
          return _buildLoadedView(state);
        } else if (state is CryptocurrencyError) {
          return _buildErrorView(
              "${Strings.failedToLoadCryptocurrencies} ${state.message}");
        } else {
          return _buildEmptyView();
        }
      },
    );
  }

  Widget _buildLoadedView(CryptocurrencyLoaded state) {
    if (state.cryptocurrencies.isNotEmpty) {
      return Stack(
        children: [
          RefreshIndicator(
            onRefresh: () => _loadCryptocurrencies(isRefresh: true),
            child: CryptoListView(
              cryptocurrencies: state.cryptocurrencies,
              scrollController: _scrollController,
            ),
          ),
          if (state.isLoadingMore) const LoadingIndicator(),
        ],
      );
    } else {
      return _buildEmptyView();
    }
  }

  Widget _buildEmptyView() {
    return EmptyStateView(
      onRefresh: () {
        context.read<CryptocurrencyBloc>().add(
              LoadCryptocurrencies(page: _page, limit: _limit),
            );
      },
    );
  }

  Widget _buildErrorView(String message) {
    return ErrorView(
      message: message,
      onRetry: () => _loadCryptocurrencies(),
    );
  }
}
