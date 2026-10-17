import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/icon_label.dart';
import '../../domain/entities/legal_list_entity.dart';
import '../../domain/entities/legal_section_entity.dart';
import '../widgets/privacy_hero_card.dart';
import '../widgets/privacy_section_tile.dart';

final class const PrivacyPolicyPage({super.key}) extends StatelessWidget {
  static final LegalListEntity _privacyPolicy = LegalListEntity(
    lastUpdated: DateTime(2026, 10, 8),
    legalSections: const <LegalSectionEntity>[
        LegalSectionEntity(
          title: "Title",
          body: "Body"
        )
    ]
  );


  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0.0,
      title: Text(context.l10n.privacyPolicy, style: TextStyles.font18Weight700),
    ),
    body: ListView(
        padding: const .all(pageContentPadding),
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          const PrivacyHeroCard(),
          const SizedBox(height: 24.0),
          Text(
            context.l10n.privacyIntro,
            style: TextStyles.font14Weight700.copyWith(color: Colors.grey)
          ),
          const SizedBox(height: 24.0),
          Material(
            clipBehavior: .antiAlias,
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const .all(.circular(16.0)),
            child: ListView.separated(
              padding: .zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _privacyPolicy.legalSections.length,
              separatorBuilder: (BuildContext context, int _) => Divider(
                height: 0.0,
                indent: 16.0,
                endIndent: 16.0,
                color: Theme.of(context).colorScheme.outline
              ),
              itemBuilder: (BuildContext context, int i) => PrivacySectionTile(
                number: i + 1,
                section: _privacyPolicy.legalSections[i],
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          IconLabel(
            icon: Icons.calendar_month_outlined,
            label: context.l10n.lastUpdated(
              DateFormat.yMMMd(context.l10n.localeName).format(_privacyPolicy.lastUpdated)
            )
          )
        ],
      ),
  );
}
