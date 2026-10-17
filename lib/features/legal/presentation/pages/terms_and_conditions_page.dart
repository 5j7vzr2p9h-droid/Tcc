import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/icon_label.dart';
import '../../domain/entities/legal_list_entity.dart';
import '../../domain/entities/legal_section_entity.dart';
import '../widgets/terms_section_tile.dart';

final class const TermsAndConditionsPage({super.key}) extends StatelessWidget {
  static final LegalListEntity _terms = LegalListEntity(
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
      title: Text(context.l10n.termsAndConditions, style: TextStyles.font18Weight700),
    ),
    body: ListView(
      padding: const .all(pageContentPadding),
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        IconLabel(
          icon: Icons.access_time,
          label: context.l10n.lastUpdated(
            DateFormat.yMMMd(context.l10n.localeName).format(_terms.lastUpdated)
          )
        ),
        const SizedBox(height: defaultItemsSeparator),
        Text(
          context.l10n.termsIntro,
          style: TextStyles.font14Weight400.copyWith(color: Colors.grey)
        ),
        const SizedBox(height: 24.0),
        Material(
          clipBehavior: .antiAlias,
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const .all(.circular(16.0)),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _terms.legalSections.length,
            separatorBuilder: (BuildContext context, int _) => Divider(
              height: 0.0,
              indent: 16.0,
              endIndent: 16.0,
              color: Theme.of(context).colorScheme.outline
            ),
            itemBuilder: (BuildContext context, int i) => TermsSectionTile(
              number: i + 1,
              section: _terms.legalSections[i],
            ),
          ),
        )
      ],
    )
  );
}