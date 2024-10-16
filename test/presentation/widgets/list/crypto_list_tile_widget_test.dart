import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/crypto_list_tile_widget.dart';

import '../../../testing_data.dart';

void main() {
  const cryptocurrency = testCryptocurrencyUiModel2;

  Widget createWidgetUnderTest() {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final args = settings.arguments as CryptocurrencyUiModel;
          return MaterialPageRoute(builder: (context) {
            return Scaffold(body: Text('Details of ${args.name}'));
          });
        }
        return null;
      },
      home: const Scaffold(
        body: CryptoListTile(crypto: cryptocurrency),
      ),
    );
  }

  testWidgets('renders cryptocurrency name and symbol correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Ethereum'), findsOneWidget);
    expect(find.text('(ETH)'), findsOneWidget);
  });

  testWidgets('navigates to details page with correct arguments on tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final listTile = find.byType(ListTile);
    await tester.tap(listTile);
    await tester.pumpAndSettle();

    expect(find.text('Details of Ethereum'), findsOneWidget);
  });
}
