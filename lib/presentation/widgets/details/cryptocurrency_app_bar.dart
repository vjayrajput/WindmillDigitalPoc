import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_state.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/widgets/details/favorite_button_widget.dart';

class CryptocurrencyAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final CryptocurrencyUiModel cryptocurrency;

  const CryptocurrencyAppBar({
    super.key,
    required this.cryptocurrency,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(cryptocurrency.name),
      actions: [
        BlocBuilder<FavoriteCurrencyBloc, FavoriteCurrencyState>(
          builder: (context, state) {
            bool isFavorite = false;
            if (state is CurrencyIsFavorite) {
              isFavorite = true;
            } else if (state is CurrencyIsNotFavorite) {
              isFavorite = false;
            }

            return FavoriteButton(
              initialIsFavorite: isFavorite,
              cryptocurrency: cryptocurrency,
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
