import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/presentation/widgets/details/crypto_details_card_widget.dart';

import '../../../testing_data.dart';

void main() {
  testWidgets('CryptoDetailsCard displays cryptocurrency details correctly',
      (WidgetTester tester) async {
    // Create a sample cryptocurrency model
    const cryptocurrency = testCryptocurrencyUiModel1;

    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CryptoDetailsCard(cryptocurrency: cryptocurrency),
        ),
      ),
    );

    // Verify that all CryptoInfoRow widgets are displayed with correct data
    expect(find.byKey(const ValueKey('cryptoIdRow')), findsOneWidget);
    expect(find.byKey(const ValueKey('cryptoNameRow')), findsOneWidget);
    expect(find.byKey(const ValueKey('cryptoSymbolRow')), findsOneWidget);
    expect(find.byKey(const ValueKey('cryptoRankRow')), findsOneWidget);
    expect(find.byKey(const ValueKey('cryptoFirstHistoricalDataRow')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('cryptoLastHistoricalDataRow')),
        findsOneWidget);

    // Verify the actual values
    expect(find.text(cryptocurrency.id.toString()), findsOneWidget);
    expect(find.text(cryptocurrency.name), findsOneWidget);
    expect(find.text(cryptocurrency.symbol), findsOneWidget);
    expect(find.text(cryptocurrency.rank.toString()), findsOneWidget);
    expect(find.text(cryptocurrency.firstHistoricalData), findsOneWidget);
    expect(find.text(cryptocurrency.lastHistoricalData), findsOneWidget);
  });
}
