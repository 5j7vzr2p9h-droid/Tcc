import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/text_styles.dart';

final class AuthHeader extends StatelessWidget {

  final String _title, _subtitle;

  const new({
    super.key,
    required this._title,
    required this._subtitle
  });

  @override
  Row build(BuildContext context)
  => Row(
    mainAxisAlignment: .center,
    spacing: 16.0,
    children: <Widget>[
      const Image(
        image:AssetImage(AssetsManager.logo),
        width: 120.0,
      ),
      Flexible(
        child: Column(
          mainAxisSize: .min,
          spacing: 4.0,
          children: <Widget>[
            Text(_title, style: TextStyles.font24Weight700),
            Text(
              _subtitle,
              style: TextStyles.font14Weight400.copyWith(color: Colors.grey)
            )
          ],
        ),
      )
    ],
  );
}