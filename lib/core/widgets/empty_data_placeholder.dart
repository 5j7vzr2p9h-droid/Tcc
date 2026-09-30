import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

final class const EmptyDataPlaceholder({
  super.key,
  required final IconData _iconData,
  required final String _title,
  final String? _description
}) extends StatelessWidget {

  @override
  Column build(BuildContext context)
  => Column(
    mainAxisSize: .min,
    spacing: 12.0,
    children: <Widget>[
      CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(25),
        radius: 48.0,
        child: Icon(
          _iconData,
          size: 44.0,
          color: Theme.of(context).colorScheme.primary
        ),
      ),
      Text(
        _title,
        style: TextStyles.font20Weight700
      ),
      if(_description is String)
        Text(
          _description,
          textAlign: .center,
          style: TextStyles.font14Weight700.copyWith(color: Colors.grey)
        )
    ],
  );
}
