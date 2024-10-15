import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/core/resources/strings.dart';
import 'package:windmill_digital_poc/presentation/widgets/list/error_view_widget.dart';

void main() {
  testWidgets('ErrorView displays the error message and retry button',
      (WidgetTester tester) async {
    // Define a mock retry callback
    bool retryClicked = false;
    void mockRetry() {
      retryClicked = true;
    }

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ErrorView(
            message: 'An error occurred!',
            onRetry: mockRetry,
          ),
        ),
      ),
    );

    // Verify that the error message is displayed
    expect(find.text('An error occurred!'), findsOneWidget);

    // Verify that the retry button is present
    expect(find.text(Strings.retry), findsOneWidget);
  });

  testWidgets('Retry button calls the onRetry callback',
      (WidgetTester tester) async {
    // Define a mock retry callback
    bool retryClicked = false;
    void mockRetry() {
      retryClicked = true;
    }

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ErrorView(
            message: 'An error occurred!',
            onRetry: mockRetry,
          ),
        ),
      ),
    );

    // Find the retry button
    final retryButton = find.text(Strings.retry);

    // Tap the retry button
    await tester.tap(retryButton);
    await tester.pump(); // Rebuild the widget after the state has changed

    // Verify that the retry callback was called
    expect(retryClicked, true);
  });
}
