import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/presentation/widgets/icon_action_button_widget.dart';

// Assuming IconButtonAction is in the same file or imported correctly
void main() {
  testWidgets('IconButtonAction renders correct icon and color', (WidgetTester tester) async {
    // Arrange
    const iconData = Icons.favorite;
    const tintColor = Colors.red;
    var widget = IconButtonAction(
      iconData: iconData,
      tintColor: tintColor,
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
    final iconButton = tester.widget<IconButton>(find.byType(IconButton));
    expect(iconButton.icon, isA<Icon>().having((i) => i.icon, 'icon', iconData));
    expect((iconButton.icon as Icon).color, tintColor);
  });

  testWidgets('IconButtonAction calls onAction when pressed', (WidgetTester tester) async {
    // Arrange
    bool wasPressed = false;
    var widget = IconButtonAction(
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
    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle(); // Wait for animations to complete

    // Assert
    expect(wasPressed, isTrue);
  });

  testWidgets('IconButtonAction uses default icon and color', (WidgetTester tester) async {
    // Arrange
    var widget = IconButtonAction(
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
    final iconButton = tester.widget<IconButton>(find.byType(IconButton));
    expect(iconButton.icon, isA<Icon>().having((i) => i.icon, 'icon', Icons.favorite_border));
    expect((iconButton.icon as Icon).color, Colors.black);
  });
}
