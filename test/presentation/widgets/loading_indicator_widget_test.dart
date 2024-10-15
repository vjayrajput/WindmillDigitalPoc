import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/presentation/widgets/loading_indicator_widget.dart';

// Assuming LoadingIndicator is in the same file or imported correctly
void main() {
  testWidgets('LoadingIndicator renders CircularProgressIndicator', (WidgetTester tester) async {
    // Arrange
    const widget = LoadingIndicator();

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('LoadingIndicator has correct height', (WidgetTester tester) async {
    // Arrange
    const widget = LoadingIndicator();

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    // Assert
    // Look for the SizedBox specifically instead of the Container
    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
    expect(sizedBox, isNotNull);
    expect(sizedBox.height, 54);
  });

  testWidgets('LoadingIndicator is aligned at the bottom center', (WidgetTester tester) async {
    // Arrange
    const widget = LoadingIndicator();

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    // Assert
    final container = tester.widget<Container>(find.byType(Container).first);
    expect(container.alignment, Alignment.bottomCenter);
  });

  testWidgets('LoadingIndicator has transparent background color', (WidgetTester tester) async {
    // Arrange
    const widget = LoadingIndicator();

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    // Assert
    final container = tester.widget<Container>(find.byType(Container).first);
    expect(container.color, Colors.transparent);
  });
}
