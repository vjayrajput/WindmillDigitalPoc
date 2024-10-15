import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/empty_crypto_view_widget.dart';

void main() {
  testWidgets('EmptyStateView displays title, text, and refresh button',
      (WidgetTester tester) async {
    // Define a mock refresh callback
    bool refreshClicked = false;
    void mockRefresh() {
      refreshClicked = true;
    }

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EmptyStateView(
            onRefresh: mockRefresh,
          ),
        ),
      ),
    );

    // Verify that the title is displayed
    expect(find.text(Strings.oopsNoDataAvailable), findsOneWidget);

    // Verify that the text label is displayed
    expect(find.text(Strings.countNotFindCrypto), findsOneWidget);

    // Verify that the refresh button is present
    expect(find.text(Strings.refresh), findsOneWidget);
  });

  testWidgets('Refresh button calls the onRefresh callback',
      (WidgetTester tester) async {
    // Define a mock refresh callback
    bool refreshClicked = false;
    void mockRefresh() {
      refreshClicked = true;
    }

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EmptyStateView(
            onRefresh: mockRefresh,
          ),
        ),
      ),
    );

    // Find the refresh button
    final refreshButton = find.text(Strings.refresh);

    // Tap the refresh button
    await tester.tap(refreshButton);
    await tester.pump(); // Rebuild the widget after the state has changed

    // Verify that the refresh callback was called
    expect(refreshClicked, true);
  });
}
