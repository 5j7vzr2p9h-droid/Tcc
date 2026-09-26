import 'package:flutter/material.dart';

import '../../../../config/theming/app_colors.dart';
import '../../../../core/enums/field_status.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

class OrderFieldTitle extends StatelessWidget {
  final String _title;
  final FieldStatus _fieldStatus;

  const new({
    super.key,
    required this._title,
    this._fieldStatus = FieldStatus.optional
  });

  @override
  Row build(BuildContext context) {
    final Color color = _fieldStatus == FieldStatus.mandatory?
      Theme.of(context).extension<AppColors>()!.mandatory!:
      Theme.of(context).extension<AppColors>()!.optional!;
    
    return Row(
      mainAxisAlignment: .start,
      spacing: 4.0,
      children: <Widget>[
        Text(
          _title,
          style: TextStyles.font14Weight700,
        ),
        Container(
          padding: const .all(4.0),
          decoration: BoxDecoration(
            color: color.withAlpha(40),
            borderRadius: .circular(12.0),
            border: .all(
              color: color,
            )
          ),
          child: Text(
            switch(_fieldStatus){
              FieldStatus.optional => context.l10n.optional,
              FieldStatus.mandatory => context.l10n.mandatory,
            },
            style: TextStyles.font12Weight400.copyWith(
              color: color
            ),
          ),
        )
      ],
    );
  }
}