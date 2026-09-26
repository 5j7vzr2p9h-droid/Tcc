import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/handled_network_image.dart';
import '../../domain/entities/legal_section_entity.dart';

final class PrivacySectionTile extends StatelessWidget {
  final int _number;
  final LegalSectionEntity _section;

  const new({
    super.key,
    required this._number,
    required this._section
  });

  @override
  Padding build(BuildContext context)
  => Padding(
    padding: const .all(16.0),
    child: Row(
      crossAxisAlignment: .start,
      spacing: 12.0,
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: .circular(12.0)
          ),
          child: HandledNetworkImage(
            imageUrl: _section.icon ?? '',
            width: 20.0,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            spacing: 4.0,
            children: <Text>[
              Text(
                "$_number. ${_section.title}",
                style: TextStyles.font16Weight700
              ),
              Text(
                _section.body,
                style: TextStyles.font14Weight700.copyWith(color: Colors.grey.shade600)
              )
            ],
          ),
        )
      ],
    ),
  );
}
