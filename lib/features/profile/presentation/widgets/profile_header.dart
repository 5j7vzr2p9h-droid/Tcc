import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class ProfileHeader extends StatelessWidget {
  final String _name, _phoneNumber;
  final VoidCallback _onEditPressed;

  const new({
    super.key,
    required this._name,
    required this._phoneNumber,
    required this._onEditPressed
  });

  @override
  Row build(BuildContext context)
  => Row(
    spacing: 16.0,
    children: <Widget>[
      CircleAvatar(
        radius: 40.0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Text(
          _name.characters.first,
          style: TextStyles.font32Weight900.copyWith(
            color: Theme.of(context).colorScheme.onPrimary
          ),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: .start,
          spacing: 4.0,
          children: <Widget>[
            Text(
              _name,
              style: TextStyles.font20Weight700
            ),
            Text(
              _phoneNumber,
              style: TextStyles.font14Weight400.copyWith(
                color: Colors.grey
              )
            ),
            TextButton.icon(
              onPressed: _onEditPressed,
              style: TextButton.styleFrom(
                padding: .zero,
                foregroundColor: Theme.of(context).colorScheme.primary,
                textStyle: TextStyles.font14Weight700,
                tapTargetSize: .shrinkWrap,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity
                )
              ),
              icon: const Icon(Icons.edit_outlined),
              label: Text(context.l10n.editProfile)
            )
          ],
        ),
      )
    ],
  );
}
