import 'package:electronic_menu/config/theming/light_theme.dart';
import 'package:electronic_menu/features/notifications/presentation/pages/notifications_page.dart';
import 'package:electronic_menu/features/notifications/presentation/widgets/no_notifications_placeholder.dart';
import 'package:electronic_menu/features/notifications/presentation/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpNotificationsTab(WidgetTester tester, Size size) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        theme: lightTheme,
        home: NotificationsTab(onOrdersPressed: (){})
      )
    );
    await tester.pumpAndSettle();
  }

  testWidgets('renders every day group with its notifications', (WidgetTester tester) async {
    await pumpNotificationsTab(tester, const Size(390, 844));

    expect(find.text("الإشعارات"), findsOneWidget);
    for(final String filter in <String>["الكل", "العروض", "الطلبات", "التحديثات"]){
      expect(find.text(filter), findsOneWidget);
    }

    expect(find.text("اليوم"), findsOneWidget);
    expect(find.text("تم تأكيد طلبك"), findsOneWidget);
    expect(find.text("منذ 10 دقائق"), findsOneWidget);
    expect(find.text("طلبك في الطريق"), findsOneWidget);
    expect(find.text("🎉 عرض خاص"), findsOneWidget);

    await tester.drag(find.byType(CustomScrollView), const Offset(0.0, -400.0));
    await tester.pumpAndSettle();

    expect(find.text("أمس"), findsOneWidget);
    expect(find.text("تم تسليم طلبك"), findsOneWidget);
    expect(find.text("أمس، 08:30 م"), findsOneWidget);

    await tester.drag(find.byType(CustomScrollView), const Offset(0.0, -400.0));
    await tester.pumpAndSettle();

    expect(find.text("20 مايو 2024"), findsOneWidget);
    expect(find.text("👋 اهلاً بك في تطبيقنا"), findsOneWidget);
  });

  testWidgets('drops the days that have no notification of the selected filter', (WidgetTester tester) async {
    await pumpNotificationsTab(tester, const Size(390, 844));

    await tester.tap(find.text("العروض"));
    await tester.pumpAndSettle();

    expect(find.byType(NotificationCard), findsOneWidget);
    expect(find.text("🎉 عرض خاص"), findsOneWidget);
    expect(find.text("اليوم"), findsOneWidget);
    expect(find.text("أمس"), findsNothing);
    expect(find.text("20 مايو 2024"), findsNothing);

    await tester.tap(find.text("التحديثات"));
    await tester.pumpAndSettle();

    expect(find.byType(NotificationCard), findsNWidgets(2));
    expect(find.text("اليوم"), findsNothing);
    expect(find.text("أمس"), findsOneWidget);
    expect(find.text("20 مايو 2024"), findsOneWidget);
  });

  testWidgets('renders the empty state', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    bool ordersPressed = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: lightTheme,
        home: Scaffold(
          body: NoNotificationsPlaceholder(
            onOrdersPressed: () => ordersPressed = true,
          ),
        )
      )
    );
    await tester.pumpAndSettle();

    expect(find.text("لا يوجد إشعارات"), findsOneWidget);
    expect(find.text("عند وجود أي إشعارات جديدة، ستظهر هنا."), findsOneWidget);
    expect(find.text("0"), findsOneWidget);

    await tester.tap(find.text("عرض الطلبات"));
    expect(ordersPressed, isTrue);
  });
}
