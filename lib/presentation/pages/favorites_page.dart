import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_state.dart';
import 'package:windmill_digital_poc/presentation/widgets/crypto_list_view_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/empty_favorites_view_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FavoritesPageState();
  }
}

class _FavoritesPageState extends State<FavoritesPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<FavoriteCurrencyBloc>().add(LoadFavorites());
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {}
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCurrencyBloc, FavoriteCurrencyState>(
      builder: (context, state) {
        print("favorite State is : ${state}");
        if (state is FavoriteCurrencyLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FavoriteCurrencyLoaded) {
          print("favorite length is : ${state.favorites.length}");
          if (state.favorites.isNotEmpty) {
            return CryptoListView(
              cryptocurrencies: state.favorites,
              scrollController: _scrollController,
            );
          } else {
            return const EmptyFavoritesView();
          }
        } else if (state is FavoriteCurrencyError) {
          return Center(
              child: Text(
                  "${Strings.failedToLoadFavoriteCryptocurrencies} ${state.message}"));
        } else {
          return const EmptyFavoritesView();
        }
      },
    );
  }
}
