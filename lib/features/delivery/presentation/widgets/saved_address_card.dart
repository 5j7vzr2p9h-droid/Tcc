import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/default_badge.dart';
import '../../../../core/widgets/icon_label.dart';
import '../../domain/entities/saved_address_entity.dart';

enum SavedAddressAction {
  edit,
  setAsDefault,
  delete
}

final class SavedAddressCard extends StatelessWidget {
  final SavedAddressEntity _address;
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
      borderRadius: .circular(16.0),
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
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: <Widget>[
              Text(
                _address.label,
                style: TextStyles.font18Weight700
              ),
              const SizedBox(height: 4.0),
              Text(
                _address.address,
                style: TextStyles.font14Weight400.copyWith(color: Colors.grey)
              ),
              Text(
                _address.details,
                style: TextStyles.font14Weight400.copyWith(color: Colors.grey)
              ),
              const SizedBox(height: 8.0),
              IconLabel(
                icon: Icons.phone,
                label: _address.phoneNumber,
                color: Colors.grey,
                style: TextStyles.font14Weight700
              )
            ],
          )
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
