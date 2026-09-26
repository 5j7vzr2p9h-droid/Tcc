import 'package:electronic_menu/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app starts on the login page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text("تسجيل الدخول"), findsNWidgets(2));
  });
}
