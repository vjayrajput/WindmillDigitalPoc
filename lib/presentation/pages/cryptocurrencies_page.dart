import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_state.dart';
import 'package:windmill_digital_poc/presentation/widgets/crypto_list_view_widget.dart';

class CryptocurrenciesPage extends StatefulWidget {
  const CryptocurrenciesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CryptocurrenciesPageState();
  }
}

class _CryptocurrenciesPageState extends State<CryptocurrenciesPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context
        .read<CryptocurrencyBloc>()
        .add(const LoadCryptocurrencies(page: 1, limit: 20));
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CryptocurrencyBloc, CryptocurrencyState>(
      builder: (context, state) {
        if (state is CryptocurrencyLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CryptocurrencyLoaded) {
          if (state.cryptocurrencies.isNotEmpty) {
            return CryptoListView(
              cryptocurrencies: state.cryptocurrencies,
              scrollController: _scrollController,
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
