import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/presentation/widgets/message_text_widget.dart';

// Assuming MessageText is in the same file or imported correctly
void main() {
  testWidgets('MessageText displays the correct message', (WidgetTester tester) async {
    // Arrange
    const message = 'Hello, World!';
    const widget = MessageText(message: message);

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    // Assert
    expect(find.text(message), findsOneWidget);
  });

  testWidgets('MessageText has default text alignment as start', (WidgetTester tester) async {
    // Arrange
    const message = 'Hello, World!';
    const widget = MessageText(message: message);

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    // Assert
    final textWidget = tester.widget<Text>(find.text(message));
    expect(textWidget.textAlign, TextAlign.start);
  });

  testWidgets('MessageText applies custom text alignment', (WidgetTester tester) async {
    // Arrange
    const message = 'Hello, World!';
    const widget = MessageText(message: message, textAlign: TextAlign.center);

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    // Assert
    final textWidget = tester.widget<Text>(find.text(message));
    expect(textWidget.textAlign, TextAlign.center);
  });
}
