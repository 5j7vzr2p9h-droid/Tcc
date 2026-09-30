import 'package:electronic_menu/config/theming/light_theme.dart';
import 'package:electronic_menu/features/orders/presentation/widgets/conditional_group_field.dart';
import 'package:electronic_menu/features/orders/presentation/widgets/exclusive_option_marker.dart';
import 'package:electronic_menu/features/root/domain/entities/item_entity.dart';
import 'package:electronic_menu/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  ConditionalGroupEntity group({int maxSelection = 0}) => ConditionalGroupEntity(
    id: 1,
    name: "اختر طبق",
    minSelection: 1,
    maxSelection: maxSelection,
    options: const <ConditionalOptionEntity>[
      ConditionalOptionEntity(id: 1, name: "أرز", price: 0.0, allowCombine: true),
      ConditionalOptionEntity(id: 2, name: "شيدر", price: 15.0, allowCombine: true),
      ConditionalOptionEntity(id: 3, name: "باستا", price: 0.0, allowCombine: false)
    ]
  );

  Future<ValueNotifier<Set<int>>> pumpGroup(WidgetTester tester, ConditionalGroupEntity group) async {
    final ValueNotifier<Set<int>> controller = ValueNotifier<Set<int>>(const <int>{});
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      MaterialApp(
        theme: lightTheme,
        locale: const Locale("ar"),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: ConditionalGroupField(group: group, controller: controller)
          )
        )
      )
    );
    await tester.pumpAndSettle();
    return controller;
  }

  Future<void> tapOption(WidgetTester tester, String name) async {
    await tester.tap(find.text(name));
    await tester.pumpAndSettle();
  }

  testWidgets('combinable options stack, and an exclusive one replaces them', (WidgetTester tester) async {
    final ValueNotifier<Set<int>> controller = await pumpGroup(tester, group());

    expect(find.text("اختر طبق"), findsOneWidget);
    // One marker in the legend and one next to the exclusive option.
    expect(find.byType(ExclusiveOptionMarker), findsNWidgets(2));

    await tapOption(tester, "أرز");
    await tapOption(tester, "شيدر");
    expect(controller.value, <int>{0, 1});

    await tapOption(tester, "باستا");
    expect(controller.value, <int>{2});

    await tapOption(tester, "أرز");
    expect(controller.value, <int>{0});

    await tapOption(tester, "أرز");
    expect(controller.value, isEmpty);
  });

  testWidgets('stops at maxSelection but still lets the exclusive option replace the selection', (WidgetTester tester) async {
    final ValueNotifier<Set<int>> controller = await pumpGroup(tester, group(maxSelection: 1));

    await tapOption(tester, "أرز");
    await tapOption(tester, "شيدر");
    expect(controller.value, <int>{1});

    await tapOption(tester, "باستا");
    expect(controller.value, <int>{2});
  });

  testWidgets('disables the rest of the combinable options once maxSelection is reached', (WidgetTester tester) async {
    const ConditionalGroupEntity twoMax = ConditionalGroupEntity(
      id: 1,
      name: "اختر صوص",
      minSelection: 0,
      maxSelection: 2,
      options: <ConditionalOptionEntity>[
        ConditionalOptionEntity(id: 1, name: "كاتشب", price: 0.0, allowCombine: true),
        ConditionalOptionEntity(id: 2, name: "مايونيز", price: 0.0, allowCombine: true),
        ConditionalOptionEntity(id: 3, name: "رانش", price: 0.0, allowCombine: true)
      ]
    );
    final ValueNotifier<Set<int>> controller = await pumpGroup(tester, twoMax);

    await tapOption(tester, "كاتشب");
    await tapOption(tester, "مايونيز");
    await tapOption(tester, "رانش");
    expect(controller.value, <int>{0, 1});
  });
}
