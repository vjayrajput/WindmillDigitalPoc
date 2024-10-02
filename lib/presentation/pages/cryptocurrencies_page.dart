import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_state.dart';
import 'package:windmill_digital_poc/presentation/widgets/crypto_list_view_widget.dart';
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
    context
        .read<CryptocurrencyBloc>()
        .add(LoadCryptocurrencies(page: _page, limit: _limit));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _page++;
      context
          .read<CryptocurrencyBloc>()
          .add(LoadCryptocurrencies(page: _page, limit: _limit));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptocurrencyBloc, CryptocurrencyState>(
      builder: (context, state) {
        if (state is CryptocurrencyLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CryptocurrencyLoaded) {
          if (state.cryptocurrencies.isNotEmpty) {
            return Stack(
              children: [
                CryptoListView(
                  cryptocurrencies: state.cryptocurrencies,
                  scrollController: _scrollController,
                ),
                if (state.isLoadingMore) const LoadingIndicator(),
              ],
            );
          } else {
            return const Center(child: Text(Strings.noData));
          }
        } else if (state is CryptocurrencyError) {
          return Center(
              child: Text(
                  "${Strings.failedToLoadCryptocurrencies} ${state.message}"));
        } else {
          return const Center(child: Text(Strings.noData));
        }
      },
    );
  }
}
