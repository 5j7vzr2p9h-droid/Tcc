import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

class TitleWithViewAll extends StatelessWidget {
  final String _title;

  const new({
    super.key,
    required this._title
  });

  @override
  Row build(BuildContext context)
  => Row(
    children: <Widget>[
      Expanded(
        child: Text(
          _title,
          style: TextStyles.font20Weight700,
        )
      ),
      TextButton.icon(
        onPressed: (){},
        iconAlignment: .end,
        style: TextButton.styleFrom(
          padding: .zero,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity
          )
        ),
        icon: const Icon(Icons.arrow_forward_ios),
        label: Text(context.l10n.viewAll)
      )
    ],
  );
}