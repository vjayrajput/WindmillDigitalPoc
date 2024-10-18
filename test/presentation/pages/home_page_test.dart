import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/cryptocurrency_state.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/load_favorites_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/load_favorites_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/load_favorites_state.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/manage_favorite_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/manage_favorite_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/manage_favorite_state.dart';
import 'package:windmill_digital_poc/presentation/models/cryptocurrency_ui_model.dart';
import 'package:windmill_digital_poc/presentation/pages/cryptocurrencies_page.dart';
import 'package:windmill_digital_poc/presentation/pages/favorites_page.dart';
import 'package:windmill_digital_poc/presentation/pages/home_page.dart';

import '../../testing_data.dart';

class MockCryptocurrencyBloc
    extends MockBloc<CryptocurrencyEvent, CryptocurrencyState>
    implements CryptocurrencyBloc {}

class MockManageFavoriteBloc
    extends MockBloc<ManageFavoriteEvent, ManageFavoriteState>
    implements ManageFavoriteBloc {}

class MockLoadFavoritesBloc
    extends MockBloc<LoadFavoritesEvent, LoadFavoritesState>
    implements LoadFavoritesBloc {}

void main() {
  late CryptocurrencyBloc cryptocurrencyBloc;
  late ManageFavoriteBloc manageFavoriteBloc;
  late LoadFavoritesBloc loadFavoritesBloc;

  setUp(() {
    cryptocurrencyBloc = MockCryptocurrencyBloc();
    manageFavoriteBloc = MockManageFavoriteBloc();
    loadFavoritesBloc = MockLoadFavoritesBloc();
  });

  tearDown(() {
    cryptocurrencyBloc.close();
    manageFavoriteBloc.close();
    loadFavoritesBloc.close();
  });

  testWidgets('AppBar displays the correct title', (WidgetTester tester) async {
    // Mock the initial state of the BLoCs
    when(() => cryptocurrencyBloc.state).thenReturn(CryptocurrencyLoading());
    when(() => loadFavoritesBloc.state).thenReturn(LoadFavoritesLoading());

    // Arrange: Provide the necessary Bloc providers
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<LoadFavoritesBloc>(
              create: (_) => loadFavoritesBloc,
            ),
            BlocProvider<CryptocurrencyBloc>(
              create: (_) => cryptocurrencyBloc,
            ),
          ],
          child: const HomePage(),
        ),
      ),
    );

    // Act: Find the AppBar title
    final appBarTitleFinder = find.text(Strings.appTitle);

    // Assert: Verify that the AppBar displays the correct title
    expect(appBarTitleFinder, findsOneWidget);
  });

  testWidgets('TabBar displays the correct tabs', (WidgetTester tester) async {
    // Mock the initial state of the BLoCs
    when(() => cryptocurrencyBloc.state).thenReturn(CryptocurrencyLoading());
    when(() => loadFavoritesBloc.state).thenReturn(LoadFavoritesLoading());

    // Arrange: Provide the necessary Bloc providers
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<LoadFavoritesBloc>(
              create: (_) => loadFavoritesBloc,
            ),
            BlocProvider<CryptocurrencyBloc>(
              create: (_) => cryptocurrencyBloc,
            ),
          ],
          child: const HomePage(),
        ),
      ),
    );

    // Act
    final currentTabFinder = find.text(Strings.currentCryptocurrencies);
    final favoritesTabFinder = find.text(Strings.favorites);

    // Assert
    expect(currentTabFinder, findsOneWidget);
    expect(favoritesTabFinder, findsOneWidget);
  });

  testWidgets(
      'TabBarView shows CryptocurrenciesPage when first tab is selected',
      (WidgetTester tester) async {
    // Mock the initial state of the BLoCs
    when(() => cryptocurrencyBloc.state).thenReturn(CryptocurrencyLoading());
    when(() => loadFavoritesBloc.state).thenReturn(LoadFavoritesLoading());

    // Arrange: Provide the necessary Bloc providers
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<LoadFavoritesBloc>(
              create: (_) => loadFavoritesBloc,
            ),
            BlocProvider<CryptocurrencyBloc>(
              create: (_) => cryptocurrencyBloc,
            ),
          ],
          child: const HomePage(),
        ),
      ),
    );

    // Act
    final cryptocurrenciesPageFinder = find.byType(CryptocurrenciesPage);

    // Assert
    expect(cryptocurrenciesPageFinder, findsOneWidget);
  });

  testWidgets('TabBarView shows FavoritesPage when second tab is selected',
      (WidgetTester tester) async {
    final cryptocurrencies = [
      testCryptocurrencyUiModel1,
      testCryptocurrencyUiModel2,
    ];

    final List<CryptocurrencyUiModel> favorites = [
      testCryptocurrencyUiModel1,
      testCryptocurrencyUiModel2,
    ];

    // Mock the initial state of the BLoCs
    when(() => cryptocurrencyBloc.state).thenReturn(CryptocurrencyLoading());
    when(() => loadFavoritesBloc.state).thenReturn(LoadFavoritesLoading());

    // Arrange: Provide the necessary Bloc providers
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<LoadFavoritesBloc>(
              create: (_) => loadFavoritesBloc,
            ),
            BlocProvider<CryptocurrencyBloc>(
              create: (_) => cryptocurrencyBloc,
            ),
          ],
          child: const HomePage(),
        ),
      ),
    );

    // Act
    // Tap on the Favorites tab
    await tester.tap(find.text('Favorites'));
    await tester.pump(
        const Duration(milliseconds: 100)); // Wait for animations to settle

    // Check that the CircularProgressIndicator is displayed (Loading state)
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Force the final state for LoadFavoritesBloc after tapping
    when(() => loadFavoritesBloc.state).thenReturn(
      LoadFavoritesLoaded(favorites),
    );
    when(() => cryptocurrencyBloc.state).thenReturn(CryptocurrencyLoaded(
        cryptocurrencies: cryptocurrencies, isLoadingMore: false));

    await tester.pump(const Duration(milliseconds: 100));

    // Verify that the FavoritesPage is displayed
    expect(find.byType(FavoritesPage), findsOneWidget);
  });

  testWidgets('TabBarView switches to FavoritesPage and shows the loaded state',
      (WidgetTester tester) async {
    final cryptocurrencies = [
      testCryptocurrencyUiModel1,
      testCryptocurrencyUiModel2,
    ];

    final List<CryptocurrencyUiModel> favorites = [
      testCryptocurrencyUiModel1,
      testCryptocurrencyUiModel2,
    ];

    // Mock the initial state of the BLoCs
    when(() => cryptocurrencyBloc.state).thenReturn(CryptocurrencyLoading());
    when(() => loadFavoritesBloc.state).thenReturn(LoadFavoritesLoading());

    // Pump the widget with both BLoCs provided
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<LoadFavoritesBloc>(
              create: (_) => loadFavoritesBloc,
            ),
            BlocProvider<CryptocurrencyBloc>(
              create: (_) => cryptocurrencyBloc,
            ),
          ],
          child: const HomePage(),
        ),
      ),
    );

    // Tap the Favorites tab
    await tester.tap(find.text('Favorites'));
    await tester.pump(
        const Duration(milliseconds: 100)); // Wait for animations to settle

    // Check that the CircularProgressIndicator is displayed (Loading state)
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Now simulate the BLoC yielding the loaded state
    when(() => loadFavoritesBloc.state).thenReturn(
      LoadFavoritesLoaded(favorites),
    );
    when(() => cryptocurrencyBloc.state).thenReturn(CryptocurrencyLoaded(
        cryptocurrencies: cryptocurrencies, isLoadingMore: false));

    await tester.pump(const Duration(milliseconds: 100));

    // Verify that the FavoritesPage is displayed
    expect(find.byType(FavoritesPage), findsOneWidget);
  });
}
