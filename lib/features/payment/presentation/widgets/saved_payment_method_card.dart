import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/default_badge.dart';
import '../../domain/entities/saved_payment_method_entity.dart';

final class SavedPaymentMethodCard extends StatelessWidget {
  final SavedPaymentMethodEntity _method;
  final VoidCallback _onTap;

  const new({
    super.key,
    required this._method,
    required this._onTap
  });

  @override
  ListTile build(BuildContext context)
  => ListTile(
    onTap: _onTap,
    tileColor: Theme.of(context).colorScheme.surface,
    shape: RoundedRectangleBorder(borderRadius: .circular(16.0)),
    contentPadding: const .symmetric(
      horizontal: 16.0,
      vertical: 8.0
    ),
    leading: SizedBox(
      width: 48.0,
      height: 32.0,
      child: _method.icon
    ),
    title: Text(
      _method.title,
      style: TextStyles.font16Weight700
    ),
    subtitle: _method.cardLastDigits == null? null: Text(
      "•••• •••• •••• ${_method.cardLastDigits}",
      style: TextStyles.font14Weight700.copyWith(color: Colors.grey)
    ),
    trailing: Row(
      mainAxisSize: .min,
      spacing: 8.0,
      children: <Widget>[
        if(_method.isDefault) const DefaultBadge(),
        const Icon(
          Icons.arrow_forward_ios,
          size: 16.0,
          color: Colors.grey
        )
      ],
    ),
  );
}
