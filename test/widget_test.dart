import 'package:electronic_menu/config/routing/routes.dart';
import 'package:electronic_menu/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app starts on the login page', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(Routes.login));
    await tester.pumpAndSettle();

    expect(find.text("تسجيل الدخول"), findsNWidgets(2));
  });
}
