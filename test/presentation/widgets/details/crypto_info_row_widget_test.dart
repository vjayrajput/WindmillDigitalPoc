import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/presentation/widgets/details/crypto_info_row_widget.dart';

void main() {
  testWidgets('CryptoInfoRow displays label and value correctly',
      (WidgetTester tester) async {
    // Define the label and value
    const String label = 'Price';
    const String value = '\$60,000';

    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CryptoInfoRow(label: label, value: value),
        ),
      ),
    );

    // Verify that the label is displayed
    expect(find.text(label), findsOneWidget);

    // Verify that the value is displayed
    expect(find.text(value), findsOneWidget);
  });

  testWidgets('CryptoInfoRow has correct padding', (WidgetTester tester) async {
    // Define the label and value
    const String label = 'Market Cap';
    const String value = '\$1 Trillion';

    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CryptoInfoRow(label: label, value: value),
        ),
      ),
    );

    // Verify the padding is applied
    final padding = tester.widget<Padding>(find.byType(Padding));
    expect(padding.padding, const EdgeInsets.symmetric(vertical: 4.0));
  });
}
