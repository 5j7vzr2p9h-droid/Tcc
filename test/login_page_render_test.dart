import 'package:electronic_menu/config/theming/light_theme.dart';
import 'package:electronic_menu/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpLoginPage(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(theme: lightTheme, home: const LoginPage())
    );
    await tester.pumpAndSettle();
  }

  testWidgets('renders the idle state', (WidgetTester tester) async {
    await pumpLoginPage(tester, const Size(390, 844));

    expect(find.text("تسجيل الدخول"), findsNWidgets(2));
    expect(find.text("مرحباً بك! سجل الدخول للمتابعة"), findsOneWidget);
    expect(find.text("رقم الهاتف"), findsOneWidget);
    expect(find.text("أدخل رقم هاتفك"), findsOneWidget);
    expect(find.text("+20"), findsOneWidget);
    expect(find.text("أو"), findsOneWidget);
    expect(find.text("إنشاء حساب"), findsOneWidget);
    expect(find.text("رقم الهاتف غير صالح"), findsNothing);
  });

  testWidgets('renders the error state after an invalid submit', (WidgetTester tester) async {
    await pumpLoginPage(tester, const Size(390, 844));

    await tester.enterText(find.byType(TextField), "01012345678");
    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text("رقم الهاتف غير صالح"), findsOneWidget);
    expect(find.textContaining("فشل تسجيل الدخول"), findsOneWidget);
    expect(
      tester.widget<ElevatedButton>(find.byType(ElevatedButton)).onPressed,
      isNull
    );

    await tester.enterText(find.byType(TextField), "1012345678");
    await tester.pumpAndSettle();
    expect(find.text("رقم الهاتف غير صالح"), findsNothing);
    expect(find.textContaining("فشل تسجيل الدخول"), findsNothing);
  });

  testWidgets('survives a short viewport and an open keyboard', (WidgetTester tester) async {
    await pumpLoginPage(tester, const Size(320, 480));

    await tester.enterText(find.byType(TextField), "01012345678");
    await tester.pump();
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text("رقم الهاتف غير صالح"), findsOneWidget);
  });
}
