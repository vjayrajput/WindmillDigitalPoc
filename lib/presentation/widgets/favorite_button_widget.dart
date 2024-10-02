import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_event.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final CryptocurrencyUiModel cryptocurrency;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.cryptocurrency,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.black,
      ),
      onPressed: () {
        final favoriteBloc = context.read<FavoriteCurrencyBloc>();
        if (isFavorite) {
          favoriteBloc.add(RemoveFavorite(cryptocurrency.id));
        } else {
          favoriteBloc.add(AddFavorite(cryptocurrency));
        }
      },
    );
  }
}
