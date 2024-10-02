import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_state.dart';
import 'package:windmill_digital_poc/presentation/widgets/crypto_list_view_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/empty_favorites_view_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/error_view_widget.dart';

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
    return BlocBuilder<FavoriteCurrencyBloc, FavoriteCurrencyState>(
      builder: (context, state) {
        if (state is FavoriteCurrencyLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FavoriteCurrencyLoaded) {
          return _buildLoadedView(state);
        } else if (state is FavoriteCurrencyError) {
          return _buildErrorView(
            "${Strings.failedToLoadFavoriteCryptocurrencies} ${state.message}",
          );
        } else {
          return const EmptyFavoritesView();
        }
      },
    );
  }

  Widget _buildLoadedView(FavoriteCurrencyLoaded state) {
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
  }

  Widget _buildErrorView(String message) {
    return ErrorView(
      message: message,
      onRetry: () => _loadFavorites(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
