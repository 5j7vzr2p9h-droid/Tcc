import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/default_badge.dart';
import '../../domain/entities/address_entity.dart';

enum SavedAddressAction {
  edit,
  setAsDefault,
  delete
}

final class SavedAddressCard extends StatelessWidget {
  final AddressEntity _address;
  final ValueChanged<SavedAddressAction> _onActionSelected;

  const new({
    super.key,
    required this._address,
    required this._onActionSelected
  });

  @override
  Container build(BuildContext context)
  => Container(
    padding: const .all(16.0),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: const .all(.circular(16.0)),
      border: .all(
        color: _address.isDefault?
          Theme.of(context).colorScheme.primary:
          Theme.of(context).colorScheme.outline
      )
    ),
    child: Row(
      spacing: 16.0,
      crossAxisAlignment: .start,
      children: <Widget>[
        Column(
          spacing: 12.0,
          children: <Widget>[
            if(_address.isDefault) const DefaultBadge(),
            Container(
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                shape: .circle,
                color: _address.isDefault?
                  Theme.of(context).colorScheme.primary.withAlpha(25):
                  Colors.grey.shade200
              ),
              child: Icon(
                Icons.location_on,
                color: _address.isDefault?
                  Theme.of(context).colorScheme.primary:
                  Colors.grey
              ),
            ),
          ],
        ),
        Text(
          _address.addressText,
          style: TextStyles.font14Weight400.copyWith(color: Colors.grey),
        ),
        PopupMenuButton<SavedAddressAction>(
          onSelected: _onActionSelected,
          iconColor: Colors.grey,
          padding: .zero,
          itemBuilder: (BuildContext context) => <PopupMenuEntry<SavedAddressAction>>[
            PopupMenuItem<SavedAddressAction>(
              value: .edit,
              child: Text(context.l10n.edit)
            ),
            PopupMenuItem<SavedAddressAction>(
              value: .setAsDefault,
              enabled: !_address.isDefault,
              child: Text(context.l10n.setAsDefault)
            ),
            PopupMenuItem<SavedAddressAction>(
              value: .delete,
              child: Text(context.l10n.delete)
            )
          ],
        )
      ],
    )
  );
}
