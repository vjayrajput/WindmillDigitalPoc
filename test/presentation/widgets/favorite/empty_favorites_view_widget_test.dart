import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/widgets/favorite/empty_favorites_view_widget.dart';

void main() {
  testWidgets('EmptyFavoritesView has a favorite icon, title, and text', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyFavoritesView(),
        ),
      ),
    );

    // Verify that the icon is present
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    // Verify that the title label is present
    expect(find.text(Strings.noFavoritesYet), findsOneWidget);

    // Verify that the instruction text is present
    expect(find.text(Strings.startAddingYourItemHere), findsOneWidget);
  });

  testWidgets('EmptyFavoritesView displays a centered layout', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: EmptyFavoritesView(),
        ),
      ),
    );

    // Verify that the icon is centered
    final iconFinder = find.byIcon(Icons.favorite_border);
    expect(tester.getCenter(iconFinder).dy, lessThan(300)); // Adjust the value as per your screen height
  });
}
