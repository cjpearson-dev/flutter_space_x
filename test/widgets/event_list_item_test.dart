import 'package:flutter/material.dart';
import 'package:flutter_space_x/ui/widgets/event_list_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EventListItem Widget Tests', () {
    testWidgets('should display title and text correctly', (
      WidgetTester tester,
    ) async {
      const title = 'Test Title';
      const text = 'Test Text';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: EventListItem(title: title, text: text)),
        ),
      );

      // Verify that the title and text are displayed correctly
      expect(find.text(title), findsOneWidget);
      expect(find.text(text), findsOneWidget);
    });

    testWidgets('should handle onPress callback when tapped', (
      WidgetTester tester,
    ) async {
      const title = 'Test Title';
      const text = 'Test Text';
      bool isPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EventListItem(
              title: title,
              text: text,
              onPress: () {
                isPressed = true;
              },
            ),
          ),
        ),
      );

      // Tap on the EventListItem
      await tester.tap(find.byType(InkWell));
      await tester.pump();

      // Verify that the onPress callback was called
      expect(isPressed, true);
    });

    testWidgets('should respect textMaxLines when provided', (
      WidgetTester tester,
    ) async {
      const title = 'Test Title';
      const text = 'Test Text';
      const textMaxLines = 2;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EventListItem(
              title: title,
              text: text,
              textMaxLines: textMaxLines,
            ),
          ),
        ),
      );

      // Find the subtitle text widget
      final subtitleText = tester.widget<Text>(find.byType(Text).last);

      // Verify that the maxLines property is set correctly
      expect(subtitleText.maxLines, textMaxLines);
    });

    testWidgets('should use null for textMaxLines when not provided', (
      WidgetTester tester,
    ) async {
      const title = 'Test Title';
      const text = 'Test Text';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: EventListItem(title: title, text: text)),
        ),
      );

      // Find the subtitle text widget
      final subtitleText = tester.widget<Text>(find.byType(Text).last);

      // Verify that null is used as the maxLines value (no limit to the number of lines)
      expect(subtitleText.maxLines, null);
    });
  });
}
