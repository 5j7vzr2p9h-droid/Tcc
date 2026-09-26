import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
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
        borderRadius: .circular(12.0),
        side: BorderSide(
          color: selected? Theme.of(context).colorScheme.primary: Theme.of(context).colorScheme.outline
        )
      ),
      title: Column(
        crossAxisAlignment: .start,
        spacing: 8.0,
        children: <Widget>[
          AddressDetailRow(label: context.l10n.region, value: _address.area),
          AddressDetailRow(label: context.l10n.street, value: _address.street),
          AddressDetailRow(label: context.l10n.details, value: _address.details),
          Row(
            children: <Widget>[
              Expanded(
                child: AddressDetailRow(label: context.l10n.apartment, value: _address.apartment),
              ),
              Expanded(
                child: AddressDetailRow(label: context.l10n.floor, value: _address.floor),
              )
            ],
          )
        ],
      ),
    );
  }
}

final class AddressDetailRow extends StatelessWidget {
  final String _label, _value;

  const new({
    super.key,
    required this._label,
    required this._value
  });

  @override
  Row build(BuildContext context)
  => Row(
    crossAxisAlignment: .start,
    spacing: 8.0,
    children: <Widget>[
      SizedBox(
        width: 52.0,
        child: Text(
          "$_label :",
          style: TextStyles.font12Weight400.copyWith(
            color: Colors.grey
          )
        ),
      ),
      Expanded(
        child: Text(
          _value,
          style: TextStyles.font14Weight700
        ),
      )
    ],
  );
}
