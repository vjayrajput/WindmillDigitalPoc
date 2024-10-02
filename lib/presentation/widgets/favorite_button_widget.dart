import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_event.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';

class FavoriteButton extends StatefulWidget {
  final bool initialIsFavorite;
  final CryptocurrencyUiModel cryptocurrency;

  const FavoriteButton({
    super.key,
    required this.initialIsFavorite,
    required this.cryptocurrency,
  });

  @override
  State<StatefulWidget> createState() {
    return _FavoriteButtonState();
  }
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialIsFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.black,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
        try {
          final favoriteBloc = BlocProvider.of<FavoriteCurrencyBloc>(context);
          if (isFavorite) {
            favoriteBloc.add(AddFavorite(widget.cryptocurrency));
          } else {
            favoriteBloc.add(RemoveFavorite(widget.cryptocurrency.id));
          }
        } catch (error) {
          print("Error while updating favorite: $error");
          setState(() {
            isFavorite = !isFavorite;
          });
        }
      },
    );
  }
}
