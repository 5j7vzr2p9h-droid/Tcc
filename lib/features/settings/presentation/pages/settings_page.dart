import 'package:flutter/material.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/app_locales.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../di.dart';
import '../../../../language_controller.dart';
import '../../../../theme_controller.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_tile.dart';

final class SettingsPage extends StatelessWidget {
  const new({super.key});

  static const String _version = "1.0.0";
  static const Map<String, String> _languages = <String, String>{
    AppLocales.ar: "العربية",
    AppLocales.en: "English"
  };

  static void _showOptionsDialog<T>(
    BuildContext context,
    {
      required String title,
      required ValueNotifier<T> controller,
      required Map<T, String> options
    }
  ) => showDialog(
    context: context,
    builder: (BuildContext context)
    => AlertDialog(
      clipBehavior: .antiAlias,
      title: Text(title, style: TextStyles.font18Weight700),
      contentPadding: const .symmetric(vertical: 16.0),
      content: RadioGroup<T>(
        groupValue: controller.value,
        onChanged: (T? value){
          Navigator.pop(context);
          if(value != null) controller.value = value;
        },
        child: Column(
          mainAxisSize: .min,
          children: <RadioListTile<T>>[
            for(final MapEntry<T, String> option in options.entries)
              RadioListTile<T>(
                value: option.key,
                title: Text(option.value, style: TextStyles.font16Weight700)
              )
          ],
        ),
      ),
    )
  );

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(context.l10n.settings, style: TextStyles.font18Weight700),
    ),
    body: ListView(
      padding: const .all(pageContentPadding),
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        SettingsSection(
          title: context.l10n.account,
          tiles: <SettingsTile>[
            SettingsTile(
              iconData: Icons.person_outline,
              title: context.l10n.accountInformation,
              subtitle: context.l10n.accountInformationSubtitle,
              onTap: (){},
            ),
            SettingsTile(
              iconData: Icons.notifications_outlined,
              title: context.l10n.notifications,
              subtitle: context.l10n.notificationsSubtitle,
              onTap: () => Navigator.pushNamed(context, Routes.notificationSettings),
            )
          ],
        ),
        const SizedBox(height: 24.0),
        SettingsSection(
          title: context.l10n.application,
          tiles: <SettingsTile>[
            SettingsTile(
              iconData: Icons.language,
              title: context.l10n.language,
              subtitle: _languages[getIt<LanguageController>().value]!,
              onTap: () => _showOptionsDialog<String>(
                context,
                title: context.l10n.language,
                controller: getIt<LanguageController>(),
                options: _languages
              ),
            ),
            SettingsTile(
              iconData: Icons.palette_outlined,
              title: context.l10n.appearance,
              subtitle: context.l10n.appearanceSubtitle,
              onTap: () => _showOptionsDialog<ThemeMode>(
                context,
                title: context.l10n.appearance,
                controller: getIt<ThemeController>(),
                options: <ThemeMode, String>{
                  .light: context.l10n.lightAppearance,
                  .dark: context.l10n.darkAppearance
                }
              ),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
        SettingsSection(
          title: context.l10n.supportAndHelp,
          tiles: <SettingsTile>[
            SettingsTile(
              iconData: Icons.headset_mic_outlined,
              title: context.l10n.helpCenter,
              subtitle: context.l10n.helpCenterSubtitle,
              onTap: () => Navigator.pushNamed(context, Routes.support),
            ),
            SettingsTile(
              iconData: Icons.description_outlined,
              title: context.l10n.termsAndConditions,
              subtitle: context.l10n.termsAndConditionsSubtitle,
              onTap: () => Navigator.pushNamed(context, Routes.termsAndConditions),
            ),
            SettingsTile(
              iconData: Icons.info_outline,
              title: context.l10n.aboutApp,
              subtitle: "${context.l10n.version} $_version",
              onTap: (){},
            )
          ],
        ),
      ],
    ),
  );
}
