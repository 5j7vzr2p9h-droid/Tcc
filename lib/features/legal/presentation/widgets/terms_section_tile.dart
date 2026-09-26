import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/legal_section_entity.dart';

final class TermsSectionTile extends StatelessWidget {
  final int _number;
  final LegalSectionEntity _section;

  const new({
    super.key,
    required this._number,
    required this._section
  });

  @override
  ExpansionTile build(BuildContext context) {
    return ExpansionTile(
    shape: const Border(),
    collapsedShape: const Border(),
    controlAffinity: .leading,
    iconColor: Theme.of(context).colorScheme.primary,
    collapsedIconColor: Theme.of(context).colorScheme.primary,
    tilePadding: const .symmetric(horizontal: 16.0),
    childrenPadding: const .fromLTRB(16.0, 0.0, 16.0, 16.0),
    expandedCrossAxisAlignment: .start,
    title: Text(
      "$_number. ${_section.title}",
      style: TextStyles.font16Weight700
    ),
    children: <Text>[
      Text(
        _section.body,
        style: TextStyles.font14Weight400.copyWith(color: Colors.grey),
        textAlign: .start,
      )
    ],
  );
  }
}
