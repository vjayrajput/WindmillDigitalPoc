import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/core/resources/styles.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_state.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/widgets/cryptocurrency_details_card_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/favorite_button_widget.dart';

class CryptocurrencyDetailPage extends StatefulWidget {
  const CryptocurrencyDetailPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CryptocurrencyDetailPageState();
  }
}

class _CryptocurrencyDetailPageState extends State<CryptocurrencyDetailPage> {
  CryptocurrencyUiModel? cryptocurrency;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        cryptocurrency =
            ModalRoute.of(context)!.settings.arguments as CryptocurrencyUiModel;
      });

      if (cryptocurrency != null) {
        final favoriteBloc = context.read<FavoriteCurrencyBloc>();
        favoriteBloc.add(CheckFavorite(cryptocurrency!.id));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cryptocurrency != null
          ? AppBar(
              title: Text(cryptocurrency!.name),
              actions: [
                BlocBuilder<FavoriteCurrencyBloc, FavoriteCurrencyState>(
                  builder: (context, state) {
                    print("details state : $state");
                    bool isFavorite = false;
                    if (state is CurrencyIsFavorite) {
                      isFavorite = true;
                    } else if (state is CurrencyIsNotFavorite) {
                      isFavorite = false;
                    }

                    return FavoriteButton(
                      initialIsFavorite: isFavorite,
                      cryptocurrency: cryptocurrency!,
                    );
                  },
                ),
              ],
            )
          : AppBar(title: const Text(Strings.loading)),
      body: cryptocurrency == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: AppThemes.cardPadding,
              child: CryptocurrencyDetailsCard(cryptocurrency: cryptocurrency!),
            ),
    );
  }
}
