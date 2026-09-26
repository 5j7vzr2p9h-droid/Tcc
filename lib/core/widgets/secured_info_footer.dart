import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

final class SecuredInfoFooter extends StatelessWidget {
  final String _message;

  const new({
    super.key,
    required this._message
  });

  @override
  Row build(BuildContext context)
  => Row(
    mainAxisAlignment: .center,
    spacing: 8.0,
    children: <Widget>[
      const Icon(
        Icons.lock_outline,
        size: 16.0,
        color: Colors.grey
      ),
      Flexible(
        child: Text(
          _message,
          style: TextStyles.font12Weight400.copyWith(color: Colors.grey)
        ),
      )
    ],
  );
}
