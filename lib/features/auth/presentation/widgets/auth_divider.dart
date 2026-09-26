import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

final class AuthDivider extends StatelessWidget {
  final String _label;

  const new({
    super.key,
    required this._label
  });

  @override
  Row build(BuildContext context)
  => Row(
    spacing: 12.0,
    children: <Widget>[
      Expanded(child: _divider(context)),
      Text(
        _label,
        style: TextStyles.font14Weight400.copyWith(color: Colors.grey)
      ),
      Expanded(child: _divider(context))
    ],
  );

  Divider _divider(BuildContext context)
  => Divider(
    height: 1.0,
    color: Theme.of(context).colorScheme.outline
  );
}
