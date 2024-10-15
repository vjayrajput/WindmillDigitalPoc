import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_state.dart';
import 'package:windmill_digital_poc/presentation/widgets/favorite/empty_favorites_view_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/crypto_list_view_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/error_view_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FavoritesPageState();
  }
}

class _FavoritesPageState extends State<FavoritesPage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadFavorites();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {}
  }

  Future<void> _loadFavorites({bool isRefresh = false}) async {
    context.read<FavoriteCurrencyBloc>().add(LoadFavorites());
  }

  Future<void> _onRefresh() async {
    await _loadFavorites(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<FavoriteCurrencyBloc, FavoriteCurrencyState>(
      builder: (context, state) {
        if (state is FavoriteCurrencyLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FavoriteCurrencyLoaded) {
          if (state.favorites.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: CryptoListView(
                cryptocurrencies: state.favorites,
                scrollController: _scrollController,
              ),
            );
          } else {
            return const EmptyFavoritesView();
          }
        } else if (state is FavoriteCurrencyError) {
          return ErrorView(
            message:
                "${Strings.failedToLoadFavoriteCryptocurrencies} ${state.message}",
            onRetry: () => _loadFavorites(),
          );
        } else {
          return const EmptyFavoritesView();
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
