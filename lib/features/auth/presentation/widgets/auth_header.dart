import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

final class AuthHeader extends StatelessWidget {
  static const double _logoSize = 120.0;

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
      CachedNetworkImage(
        imageUrl: "https://www.pngall.com/wp-content/uploads/8/Restaurant-Logo-PNG-Image-HD.png",
        height: _logoSize,
        width: _logoSize,
        fit: .contain,
        errorWidget: (BuildContext context, String url, Object error)
        => const SizedBox.shrink(),
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