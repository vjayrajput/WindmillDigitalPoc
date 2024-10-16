import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_state.dart';
import 'package:windmill_digital_poc/presentation/pages/cryptocurrencies_page.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/crypto_list_success_body.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/empty_crypto_view_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/error_view_widget.dart';

import '../../testing_data.dart';

class MockCryptocurrencyBloc
    extends MockBloc<CryptocurrencyEvent, CryptocurrencyState>
    implements CryptocurrencyBloc {}

void main() {
  late CryptocurrencyBloc cryptocurrencyBloc;

  setUp(() {
    cryptocurrencyBloc = MockCryptocurrencyBloc();
  });

  tearDown(() {
    cryptocurrencyBloc.close();
  });

  Widget createTestableWidget(Widget widget) {
    return BlocProvider<CryptocurrencyBloc>(
      create: (_) => cryptocurrencyBloc,
      child: MaterialApp(
        home: Scaffold(body: widget),
      ),
    );
  }

  testWidgets(
      'should show loading indicator when state is CryptocurrencyLoading',
      (WidgetTester tester) async {
    // Arrange
    when(() => cryptocurrencyBloc.state).thenReturn(CryptocurrencyLoading());

    // Act
    await tester.pumpWidget(createTestableWidget(const CryptocurrenciesPage()));

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'should show cryptocurrencies list when state is CryptocurrencyLoaded',
      (WidgetTester tester) async {
    // Arrange
    final cryptocurrencies = [
      testCryptocurrencyUiModel1,
      testCryptocurrencyUiModel2,
    ];
    when(() => cryptocurrencyBloc.state).thenReturn(CryptocurrencyLoaded(
        cryptocurrencies: cryptocurrencies, isLoadingMore: false));

    // Act
    await tester.pumpWidget(createTestableWidget(const CryptocurrenciesPage()));

    // Assert
    expect(find.byType(CryptoListSuccessBody), findsOneWidget);
    expect(find.text('Bitcoin'), findsOneWidget);
    expect(find.text('Ethereum'), findsOneWidget);
  });

  testWidgets('should show error view when state is CryptocurrencyError',
      (WidgetTester tester) async {
    // Arrange
    const errorMessage = 'Network error';
    when(() => cryptocurrencyBloc.state)
        .thenReturn(const CryptocurrencyError(message: errorMessage));

    // Act
    await tester.pumpWidget(createTestableWidget(const CryptocurrenciesPage()));

    // Assert
    expect(find.byType(ErrorView), findsOneWidget);
    expect(
        find.text('Failed to load cryptocurrencies with status: Network error'),
        findsOneWidget);
  });

  testWidgets('should show empty view when state is empty',
      (WidgetTester tester) async {
    // Arrange
    when(() => cryptocurrencyBloc.state).thenReturn(CryptocurrencyInitial());

    // Act
    await tester.pumpWidget(createTestableWidget(const CryptocurrenciesPage()));

    // Assert
    expect(find.byType(EmptyStateView), findsOneWidget);
  });
}
