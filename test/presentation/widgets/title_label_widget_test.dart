import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:windmill_digital_poc/core/resources/styles.dart';
import 'package:windmill_digital_poc/presentation/widgets/title_label_widget.dart';

// Assuming TitleLabel is in the same file or imported correctly
void main() {
  testWidgets('TitleLabel displays the correct text',
      (WidgetTester tester) async {
    // Arrange
    const label = 'Test Title';
    const widget = TitleLabel(label: label);

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    // Assert
    expect(find.text(label), findsOneWidget);
  });

  testWidgets('TitleLabel has default text alignment as start',
      (WidgetTester tester) async {
    // Arrange
    const label = 'Test Title';
    const widget = TitleLabel(label: label);

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    // Assert
    final textWidget = tester.widget<Text>(find.text(label));
    expect(textWidget.textAlign, TextAlign.start);
  });

  testWidgets('TitleLabel applies custom text alignment',
      (WidgetTester tester) async {
    // Arrange
    const label = 'Test Title';
    const widget = TitleLabel(label: label, textAlign: TextAlign.center);

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    // Assert
    final textWidget = tester.widget<Text>(find.text(label));
    expect(textWidget.textAlign, TextAlign.center);
  });

  testWidgets('TitleLabel uses the correct text style',
      (WidgetTester tester) async {
    // Arrange
    const label = 'Test Title';
    const widget = TitleLabel(label: label);

    // Act
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      ),
    );

    // Assert
    final textWidget = tester.widget<Text>(find.text(label));
    expect(textWidget.style, AppTextStyles.titleStyle);
  });
}
