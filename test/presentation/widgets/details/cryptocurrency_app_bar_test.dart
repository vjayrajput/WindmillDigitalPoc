import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/manage_favorite_bloc.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/manage_favorite_event.dart';
import 'package:windmill_digital_poc/presentation/bloc/favorite/manage_favorite_state.dart';
import 'package:windmill_digital_poc/presentation/widgets/details/cryptocurrency_app_bar.dart';

import '../../../testing_data.dart';

// Mock ManageFavoriteBloc
class MockManageFavoriteBloc
    extends MockBloc<ManageFavoriteEvent, ManageFavoriteState>
    implements ManageFavoriteBloc {}

class FakeManageFavoriteState extends Fake implements ManageFavoriteState {}

class FakeManageFavoriteEvent extends Fake implements ManageFavoriteEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeManageFavoriteEvent());
    registerFallbackValue(FakeManageFavoriteState());
  });

  late ManageFavoriteBloc manageFavoriteBloc;

  setUp(() {
    manageFavoriteBloc = MockManageFavoriteBloc();
  });

  const cryptocurrency = testCryptocurrencyUiModel1;

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<ManageFavoriteBloc>.value(
        value: manageFavoriteBloc,
        child: const Scaffold(
          appBar: CryptocurrencyAppBar(
            cryptocurrency: cryptocurrency,
          ),
        ),
      ),
    );
  }

  testWidgets('renders AppBar with cryptocurrency name', (WidgetTester tester) async {
    when(() => manageFavoriteBloc.state).thenReturn(ManageFavoriteInitial());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Bitcoin'), findsOneWidget);
  });

  testWidgets('displays favorite icon when state is LoadedFavoriteStatus and isFavorite is true', (WidgetTester tester) async {
    when(() => manageFavoriteBloc.state).thenReturn(LoadedFavoriteStatus(currency: cryptocurrency, isFavorite: true));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
  });

  testWidgets('displays favorite_border icon when state is LoadedFavoriteStatus and isFavorite is false', (WidgetTester tester) async {
    when(() => manageFavoriteBloc.state).thenReturn(LoadedFavoriteStatus(currency: cryptocurrency, isFavorite: false));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
  });

  testWidgets('adds RemoveFavoriteEvent when favorite icon is tapped and currency is already favorite', (WidgetTester tester) async {
    when(() => manageFavoriteBloc.state).thenReturn(LoadedFavoriteStatus(currency: cryptocurrency, isFavorite: true));

    await tester.pumpWidget(createWidgetUnderTest());

    final favoriteButton = find.byIcon(Icons.favorite);
    await tester.tap(favoriteButton);
    await tester.pump();

    verify(() => manageFavoriteBloc.add(RemoveFavoriteEvent(cryptocurrency))).called(1);
  });

  testWidgets('adds AddFavoriteEvent when favorite_border icon is tapped and currency is not favorite', (WidgetTester tester) async {
    when(() => manageFavoriteBloc.state).thenReturn(LoadedFavoriteStatus(currency: cryptocurrency, isFavorite: false));

    await tester.pumpWidget(createWidgetUnderTest());

    final favoriteBorderButton = find.byIcon(Icons.favorite_border);
    await tester.tap(favoriteBorderButton);
    await tester.pump();

    verify(() => manageFavoriteBloc.add(AddFavoriteEvent(cryptocurrency))).called(1);
  });

  testWidgets('renders nothing when state is not LoadedFavoriteStatus', (WidgetTester tester) async {
    when(() => manageFavoriteBloc.state).thenReturn(ManageFavoriteInitial());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byIcon(Icons.favorite), findsNothing);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
  });
}
