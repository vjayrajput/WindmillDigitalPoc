import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/crypto_list_success_body.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/cryptocurrency_list_view.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/empty_crypto_view_widget.dart';

import '../../../testing_data.dart';

class MockOnRefresh extends Mock {
  Future<void> call();
}

void main() {
  late ScrollController scrollController;
  late Future<void> Function() mockOnRefresh;

  setUp(() {
    scrollController = ScrollController();
    mockOnRefresh = MockOnRefresh();
  });

  tearDown(() {
    scrollController.dispose();
  });

  Widget createWidgetUnderTest({
    required List<CryptocurrencyUiModel> cryptocurrencies,
    required bool isLoadingMore,
    required Future<void> Function() onRefresh,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: CryptoListSuccessBody(
          cryptocurrencies: cryptocurrencies,
          scrollController: scrollController,
          isLoadingMore: isLoadingMore,
          onRefresh: mockOnRefresh,
        ),
      ),
    );
  }

  testWidgets(
      'renders CryptocurrencyListView when cryptocurrencies are not empty',
      (WidgetTester tester) async {
    final List<CryptocurrencyUiModel> cryptocurrencies = [
      testCryptocurrencyUiModel1,
      testCryptocurrencyUiModel2,
    ];

    await tester.pumpWidget(createWidgetUnderTest(
      cryptocurrencies: cryptocurrencies,
      isLoadingMore: false,
      onRefresh: mockOnRefresh,
    ));

    // Assert
    expect(find.byType(CryptocurrencyListView), findsOneWidget);
    expect(find.byType(EmptyStateView), findsNothing);
  });

  testWidgets('renders EmptyStateView when cryptocurrencies are empty',
      (WidgetTester tester) async {
    final List<CryptocurrencyUiModel> cryptocurrencies = [];

    await tester.pumpWidget(createWidgetUnderTest(
      cryptocurrencies: cryptocurrencies,
      isLoadingMore: false,
      onRefresh: mockOnRefresh,
    ));

    expect(find.byType(EmptyStateView), findsOneWidget);
    expect(find.byType(CryptocurrencyListView), findsNothing);
  });

  testWidgets('calls onRefresh when pull to refresh is triggered without mock',
      (WidgetTester tester) async {
    final List<CryptocurrencyUiModel> cryptocurrencies = [
      testCryptocurrencyUiModel1,
    ];

    await tester.pumpWidget(createWidgetUnderTest(
      cryptocurrencies: cryptocurrencies,
      isLoadingMore: false,
      onRefresh: mockOnRefresh,
    ));

    await tester.drag(
        find.byType(CryptocurrencyListView), const Offset(0, 100));
    await tester.pumpAndSettle();
  });
}
