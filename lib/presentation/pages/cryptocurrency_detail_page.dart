import 'package:flutter/material.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';

class CryptocurrencyDetailPage extends StatefulWidget {
  const CryptocurrencyDetailPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CryptocurrencyDetailPageState();
  }
}

class _CryptocurrencyDetailPageState extends State<CryptocurrencyDetailPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final CryptocurrencyUiModel cryptocurrency =
        ModalRoute.of(context)!.settings.arguments as CryptocurrencyUiModel;

    return Scaffold(
      appBar: AppBar(
        title: Text(cryptocurrency.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${Strings.cryptocurrencyId}${cryptocurrency.id}"),
            Text("${Strings.name}${cryptocurrency.name}"),
            Text("${Strings.symbol}${cryptocurrency.symbol}"),
            Text("${Strings.rank}${cryptocurrency.rank}"),
            Text(
                "${Strings.firstHistoricalData}${cryptocurrency.firstHistoricalData}"),
            Text(
                "${Strings.lastHistoricalData}${cryptocurrency.lastHistoricalData}"),
            // Add other fields as necessary
          ],
        ),
      ),
    );
  }
}
