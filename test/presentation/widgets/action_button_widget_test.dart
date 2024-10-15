import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/presentation/widgets/action_button_widget.dart';

// Assuming ActionButton is in the same file or imported correctly
void main() {
  testWidgets('ActionButton displays the correct label', (WidgetTester tester) async {
    // Arrange
    const label = 'Click Me';
    var widget = ActionButton(
      label: label,
      onAction: () {}, // Provide a dummy function
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    // Assert
    expect(find.text(label), findsOneWidget);
  });

  testWidgets('ActionButton calls onAction when pressed', (WidgetTester tester) async {
    // Arrange
    bool wasPressed = false;
    var widget = ActionButton(
      label: 'Click Me',
      onAction: () {
        wasPressed = true; // Update state when pressed
      },
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    // Press the button
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(); // Wait for animations to complete

    // Assert
    expect(wasPressed, isTrue);
  });
}
