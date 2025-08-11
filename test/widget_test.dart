import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:demo_sample/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialTrackerApp());

    // Verify that the home page is displayed.
    expect(find.text('Material Tracker'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });
}
