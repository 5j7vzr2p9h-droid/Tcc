import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the no internet placeholder', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpAndSettle();

    expect(find.text("LOGO"), findsOneWidget);
    expect(find.text("لا يوجد اتصال بالإنترنت"), findsOneWidget);
    expect(find.text("إعادة المحاولة"), findsNWidgets(2));
    expect(find.byIcon(Icons.wifi_off_rounded), findsOneWidget);
  });
}
