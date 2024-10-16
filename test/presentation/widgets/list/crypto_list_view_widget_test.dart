import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/crypto_list_tile_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/crypto_list_view_widget.dart';

import '../../../testing_data.dart';

void main() {
  final cryptocurrencies = [
    testCryptocurrencyUiModel1,
    testCryptocurrencyUiModel2,
  ];

  Widget createWidgetUnderTest(ScrollController controller) {
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
      home: Scaffold(
        body: CryptoListView(
          cryptocurrencies: cryptocurrencies,
          scrollController: controller,
        ),
      ),
    );
  }

  testWidgets('renders the correct number of CryptoListTile widgets',
      (WidgetTester tester) async {
    final scrollController = ScrollController();

    await tester.pumpWidget(createWidgetUnderTest(scrollController));

    expect(find.byType(CryptoListTile), findsNWidgets(2));
    expect(find.text('Bitcoin'), findsOneWidget);
    expect(find.text('Ethereum'), findsOneWidget);
  });

  testWidgets('scrolls through the list of cryptocurrencies',
      (WidgetTester tester) async {
    final scrollController = ScrollController();

    await tester.pumpWidget(createWidgetUnderTest(scrollController));

    expect(find.text('Bitcoin'), findsOneWidget);
    expect(find.text('Ethereum'), findsOneWidget);

    scrollController.jumpTo(0);
    await tester.pumpAndSettle();

    expect(scrollController.offset, 0);
  });

  testWidgets('navigates to details page when tapping on a list item',
      (WidgetTester tester) async {
    final scrollController = ScrollController();

    await tester.pumpWidget(createWidgetUnderTest(scrollController));

    await tester.tap(find.text('Bitcoin'));
    await tester.pumpAndSettle();

    expect(find.text('Details of Bitcoin'), findsOneWidget);
  });
}
