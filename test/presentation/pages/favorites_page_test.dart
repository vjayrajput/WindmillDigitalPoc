import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/load_favorites_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/load_favorites_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/load_favorites_state.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/pages/favorites_page.dart';
import 'package:windmill_digital_poc/presentation/widgets/favorite/empty_favorites_view_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/crypto_list_view_widget.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/error_view_widget.dart';

import '../../testing_data.dart';

class MockLoadFavoritesBloc
    extends MockBloc<LoadFavoritesEvent, LoadFavoritesState>
    implements LoadFavoritesBloc {}

void main() {
  late LoadFavoritesBloc loadFavoritesBloc;

  setUp(() {
    loadFavoritesBloc = MockLoadFavoritesBloc();
  });

  tearDown(() {
    loadFavoritesBloc.close();
  });

  testWidgets('displays CircularProgressIndicator when loading favorites',
      (WidgetTester tester) async {
    when(() => loadFavoritesBloc.state).thenReturn(LoadFavoritesLoading());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: loadFavoritesBloc,
          child: const FavoritesPage(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays CryptoListView when favorites are loaded',
      (WidgetTester tester) async {
    // Mock a non-empty list of favorite cryptocurrencies
    final List<CryptocurrencyUiModel> favorites = [
      testCryptocurrencyUiModel1,
      testCryptocurrencyUiModel2,
    ];

    // Mock the bloc state to return loaded favorites
    when(() => loadFavoritesBloc.state)
        .thenReturn(LoadFavoritesLoaded(favorites));

    // Pump the widget into the test environment
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: loadFavoritesBloc,
          child: const FavoritesPage(),
        ),
      ),
    );

    // Wait for all animations and renders to complete
    await tester.pumpAndSettle();

    // Verify that the CryptoListView is displayed
    expect(find.byType(CryptoListView), findsOneWidget);
  });

  testWidgets('displays EmptyFavoritesView when no favorites are found',
      (WidgetTester tester) async {
    when(() => loadFavoritesBloc.state)
        .thenReturn(const LoadFavoritesLoaded([]));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: loadFavoritesBloc,
          child: const FavoritesPage(),
        ),
      ),
    );

    expect(find.byType(EmptyFavoritesView), findsOneWidget);
  });

  testWidgets('displays ErrorView on LoadFavoritesError state',
      (WidgetTester tester) async {
    const errorMessage = 'Some error occurred';

    when(() => loadFavoritesBloc.state)
        .thenReturn(const LoadFavoritesError(message: errorMessage));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: loadFavoritesBloc,
          child: const FavoritesPage(),
        ),
      ),
    );

    expect(find.byType(ErrorView), findsOneWidget);
    expect(
        find.text(
            '${Strings.failedToLoadFavoriteCryptocurrencies} $errorMessage'),
        findsOneWidget);
  });

  testWidgets('triggers refresh when pulled down', (WidgetTester tester) async {
    // Mock a non-empty list of favorite cryptocurrencies
    final List<CryptocurrencyUiModel> favorites = [
      testCryptocurrencyUiModel1,
      testCryptocurrencyUiModel2,
    ];

    // Mock the bloc state to be in a loaded state with favorites
    when(() => loadFavoritesBloc.state)
        .thenReturn(LoadFavoritesLoaded(favorites));

    // Pump the widget into the test environment
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: loadFavoritesBloc,
          child: const FavoritesPage(),
        ),
      ),
    );

    // Wait for all animations and renders to complete
    await tester.pumpAndSettle();

    // Perform the pull-down refresh action
    await tester.drag(find.byType(RefreshIndicator), const Offset(0.0, 300.0));
    await tester.pump();

    // Verify that the refresh event (LoadFavorites) was triggered
    verify(() => loadFavoritesBloc.add(LoadFavorites())).called(1);
  });
}
