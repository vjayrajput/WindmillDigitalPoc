import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_state.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/crypto_list_success_body.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/empty_crypto_view_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/error_view_widget.dart';

class CryptocurrenciesPage extends StatefulWidget {
  const CryptocurrenciesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CryptocurrenciesPageState();
  }
}

class _CryptocurrenciesPageState extends State<CryptocurrenciesPage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadCryptocurrencies();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<CryptocurrencyBloc>().add(const LoadMoreCryptocurrencies());
    }
  }

  Future<void> _loadCryptocurrencies() async {
    context.read<CryptocurrencyBloc>().add(const LoadCryptocurrencies());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CryptocurrencyBloc, CryptocurrencyState>(
      builder: (context, state) {
        if (state is CryptocurrencyLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CryptocurrencyLoaded) {
          return CryptoListSuccessBody(
            cryptocurrencies: state.cryptocurrencies,
            scrollController: _scrollController,
            isLoadingMore: state.isLoadingMore,
            onRefresh: () => _loadCryptocurrencies(),
          );
        } else if (state is CryptocurrencyError) {
          return ErrorView(
            message: "${Strings.failedToLoadCryptocurrencies} ${state.message}",
            onRetry: () => _loadCryptocurrencies(),
          );
        } else {
          return EmptyStateView(onRefresh: () => _loadCryptocurrencies());
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
