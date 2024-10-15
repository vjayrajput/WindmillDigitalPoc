import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite_currency_event.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/widgets/details/cryptocurrency_app_bar.dart';
import 'package:windmill_digital_poc/presentation/widgets/details/cryptocurrency_detail_body.dart';

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
          ? CryptocurrencyAppBar(cryptocurrency: cryptocurrency!)
          : AppBar(title: const Text(Strings.loading)),
      body: CryptocurrencyDetailBody(cryptocurrency: cryptocurrency),
    );
  }
}
