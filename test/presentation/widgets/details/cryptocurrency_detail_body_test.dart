import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/presentation/widgets/details/crypto_details_card_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/details/cryptocurrency_detail_body.dart';

import '../../../testing_data.dart';

void main() {
  testWidgets(
      'CryptocurrencyDetailBody shows loading indicator when cryptocurrency is null',
      (WidgetTester tester) async {
    // Build the widget with null cryptocurrency
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CryptocurrencyDetailBody(cryptocurrency: null),
        ),
      ),
    );

    // Verify that a CircularProgressIndicator is displayed
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'CryptocurrencyDetailBody displays details when cryptocurrency is provided',
      (WidgetTester tester) async {
    // Create a sample cryptocurrency model
    const cryptocurrency = testCryptocurrencyUiModel1;

    // Build the widget with a non-null cryptocurrency
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CryptocurrencyDetailBody(cryptocurrency: cryptocurrency),
        ),
      ),
    );

    // Verify that the CryptoDetailsCard is displayed
    expect(find.byType(CryptoDetailsCard), findsOneWidget);
  });
}
