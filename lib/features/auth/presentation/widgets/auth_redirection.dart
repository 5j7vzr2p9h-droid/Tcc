import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

final class AuthRedirection extends StatelessWidget {
  final String _question, _actionLabel;
  final VoidCallback _onPressed;

  const new({
    super.key,
    required this._question,
    required this._actionLabel,
    required this._onPressed
  });

  @override
  Row build(BuildContext context)
  => Row(
    mainAxisAlignment: .center,
    spacing: 8.0,
    children: <Widget>[
      Flexible(
        child: Text(
          _question,
          overflow: .ellipsis,
          style: TextStyles.font14Weight400.copyWith(color: Colors.grey)
        ),
      ),
      Flexible(
        child: GestureDetector(
          onTap: _onPressed,
          child: Text(
            _actionLabel,
            overflow: .ellipsis,
            style: TextStyles.font14Weight700.copyWith(
              color: Theme.of(context).colorScheme.primary
            )
          ),
        ),
      )
    ],
  );
}
