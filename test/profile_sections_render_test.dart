import 'package:electronic_menu/config/theming/light_theme.dart';
import 'package:electronic_menu/features/coupons/presentation/pages/coupons_and_offers_page.dart';
import 'package:electronic_menu/features/delivery/presentation/pages/saved_addresses_page.dart';
import 'package:electronic_menu/features/favorites/presentation/pages/favorites_page.dart';
import 'package:electronic_menu/features/legal/presentation/pages/privacy_policy_page.dart';
import 'package:electronic_menu/features/legal/presentation/pages/terms_and_conditions_page.dart';
import 'package:electronic_menu/features/payment/presentation/pages/payment_methods_page.dart';
import 'package:electronic_menu/features/settings/presentation/pages/settings_page.dart';
import 'package:electronic_menu/features/support/presentation/pages/support_page.dart';
import 'package:electronic_menu/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpPage(WidgetTester tester, Widget page) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        theme: lightTheme,
        locale: const Locale("ar"),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates
        ],
        supportedLocales: const <Locale>[Locale("ar"), Locale("en")],
        home: page
      )
    );
    await tester.pumpAndSettle();
  }

  testWidgets('renders the coupons and offers page', (WidgetTester tester) async {
    await pumpPage(tester, const CouponsAndOffersPage());

    expect(find.text("الكوبونات والعروض"), findsOneWidget);
    expect(find.text("SWIFT20"), findsOneWidget);
    expect(find.text("FREESHIP"), findsOneWidget);
    expect(find.text("3 من 5"), findsOneWidget);
    expect(find.text("غير محدود"), findsOneWidget);
  });

  testWidgets('renders the favorites page tabs', (WidgetTester tester) async {
    await pumpPage(tester, const FavoritesPage());

    expect(find.text("المفضلة"), findsOneWidget);
    expect(find.text("شاكلامة"), findsOneWidget);

    await tester.tap(find.text("الأطعمة"));
    await tester.pumpAndSettle();

    expect(find.text("كريب تشيكن رانش"), findsOneWidget);
    expect(find.text("110.00 ج.م"), findsOneWidget);
  });

  testWidgets('renders the settings page sections', (WidgetTester tester) async {
    await pumpPage(tester, const SettingsPage());

    expect(find.text("الإعدادات"), findsOneWidget);
    expect(find.text("معلومات الحساب"), findsOneWidget);

    await tester.drag(find.byType(ListView).first, const Offset(0.0, -600.0));
    await tester.pumpAndSettle();

    expect(find.text("مركز المساعدة"), findsOneWidget);
    expect(find.text("تسجيل الخروج"), findsOneWidget);
  });

  testWidgets('renders the saved addresses page', (WidgetTester tester) async {
    await pumpPage(tester, const SavedAddressesPage());

    expect(find.text("العناوين المحفوظة"), findsOneWidget);
    expect(find.text("المنزل"), findsOneWidget);
    expect(find.text("الافتراضي"), findsOneWidget);
  });

  testWidgets('renders the payment methods page', (WidgetTester tester) async {
    await pumpPage(tester, const PaymentMethodsPage());

    expect(find.text("طرق الدفع"), findsOneWidget);
    expect(find.text("Mastercard"), findsOneWidget);
    expect(find.text("•••• •••• •••• 4567"), findsOneWidget);
  });

  testWidgets('renders the terms and conditions page', (WidgetTester tester) async {
    await pumpPage(tester, const TermsAndConditionsPage());

    expect(find.text("1. قبول الشروط"), findsOneWidget);
    expect(find.text("موافق"), findsOneWidget);
  });

  testWidgets('renders the privacy policy page', (WidgetTester tester) async {
    await pumpPage(tester, const PrivacyPolicyPage());

    expect(find.text("خصوصيتك تهمنا"), findsOneWidget);
    expect(find.text("1. المعلومات التي نجمعها"), findsOneWidget);
  });

  testWidgets('renders the support page', (WidgetTester tester) async {
    await pumpPage(tester, const SupportPage());

    expect(find.text("كيف يمكننا مساعدتك؟"), findsOneWidget);
    expect(find.text("مشكلة في الطلب"), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0.0, -600.0));
    await tester.pumpAndSettle();

    expect(find.text("تواصل معنا"), findsOneWidget);
    expect(find.text("تحدث مع الدعم"), findsOneWidget);
  });
}
