import 'package:flutter/material.dart';

import '../../domain/entities/address_entity.dart';

final class AddressCard extends StatelessWidget {
  final AddressEntity _address;

  const new({
    super.key,
    required this._address
  });

  @override
  RadioListTile<AddressEntity> build(BuildContext context) {
    final bool selected = RadioGroup.maybeOf<AddressEntity>(context)?.groupValue == _address;

    return RadioListTile<AddressEntity>(
      value: _address,
      controlAffinity: .trailing,
      contentPadding: const .all(16.0),
      dense: true,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity
      ),
      materialTapTargetSize: .shrinkWrap,
      minVerticalPadding: 0.0,
      horizontalTitleGap: 4.0,
      tileColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: const .all(.circular(12.0)),
        side: BorderSide(
          color: selected? Theme.of(context).colorScheme.primary: Theme.of(context).colorScheme.outline
        )
      ),
      title: Text(_address.addressText),
    );
  }
}