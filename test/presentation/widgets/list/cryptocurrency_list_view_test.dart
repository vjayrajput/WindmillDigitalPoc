import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/crypto_list_view_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/cryptocurrency_list_view.dart';

import '../../../testing_data.dart';

class MockOnRefresh extends Mock {
  Future<void> call();
}

void main() {
  final cryptocurrencies = [
    testCryptocurrencyUiModel1,
    testCryptocurrencyUiModel2,
  ];

  late ScrollController scrollController;
  late MockOnRefresh mockOnRefresh;

  setUp(() {
    scrollController = ScrollController();
    mockOnRefresh = MockOnRefresh();
  });

  Widget createWidgetUnderTest({required bool isLoadingMore}) {
    return MaterialApp(
      home: Scaffold(
        body: CryptocurrencyListView(
          cryptocurrencies: cryptocurrencies,
          scrollController: scrollController,
          isLoadingMore: isLoadingMore,
          onRefresh: mockOnRefresh,
        ),
      ),
    );
  }

  Widget createMinimalTestWidget(Future<void> Function() onRefresh) {
    return MaterialApp(
      home: Scaffold(
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
          ),
        ),
      ),
    );
  }

  testWidgets('triggers onRefresh in minimal widget setup',
      (WidgetTester tester) async {
    final mockOnRefresh = MockOnRefresh();

    when(() => mockOnRefresh.call()).thenAnswer((_) async {});

    await tester.pumpWidget(createMinimalTestWidget(mockOnRefresh));

    await tester.drag(find.byType(ListView), const Offset(0, 300));
    await tester.pump();

    await tester.pumpAndSettle();

    verify(() => mockOnRefresh.call()).called(1);
  });

  testWidgets('renders RefreshIndicator and CryptoListView',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(isLoadingMore: false));

    expect(find.byType(RefreshIndicator), findsOneWidget);
    expect(find.byType(CryptoListView), findsOneWidget);
    expect(find.text('Bitcoin'), findsOneWidget);
    expect(find.text('Ethereum'), findsOneWidget);
  });

  testWidgets('displays LoadingIndicator when isLoadingMore is true',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(isLoadingMore: true));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('does not display LoadingIndicator when isLoadingMore is false',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(isLoadingMore: false));

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
