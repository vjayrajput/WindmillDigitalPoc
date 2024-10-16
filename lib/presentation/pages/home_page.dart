import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/pages/cryptocurrencies_page.dart';
import 'package:windmill_digital_poc/presentation/pages/favorites_page.dart';
import 'package:windmill_digital_poc/presentation/widgets/text_label_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TextLabel(label: Strings.appTitle),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: Strings.currentCryptocurrencies,
                icon: Icon(Icons.currency_bitcoin_outlined),
              ),
              Tab(
                text: Strings.favorites,
                icon: Icon(Icons.favorite_border_outlined),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CryptocurrenciesPage(),
            FavoritesPage(),
          ],
        ),
      ),
    );
  }
}
