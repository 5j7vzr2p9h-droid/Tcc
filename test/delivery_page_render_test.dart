import 'package:electronic_menu/config/theming/light_theme.dart';
import 'package:electronic_menu/features/location/presentation/pages/select_location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpPage(WidgetTester tester, Widget page, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(theme: lightTheme, home: page)
    );
    await tester.pumpAndSettle();
  }
}
