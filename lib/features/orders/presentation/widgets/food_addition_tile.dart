import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import 'exclusive_option_marker.dart';

final class FoodAdditionTile extends StatelessWidget {
  final String _title;
  final double? _price;
  final bool _value, _enabled, _isExclusive;
  final ValueChanged<bool> _onChanged;

  const new({
    super.key,
    required this._title,
    this._price,
    required this._value,
    required this._onChanged,
    this._enabled = true,
    this._isExclusive = false
  });

  @override
  CheckboxListTile build(BuildContext context)
  => CheckboxListTile(
    onChanged: (bool? newValue) => _onChanged(newValue!),
    value: _value,
    enabled: _enabled,
    controlAffinity: .leading,
    contentPadding: const .all(12.0),
    dense: true,
    visualDensity: const VisualDensity(
      horizontal: VisualDensity.minimumDensity,
      vertical: VisualDensity.minimumDensity,
    ),
    materialTapTargetSize: .shrinkWrap,
    minVerticalPadding: 0.0,
    horizontalTitleGap: 4.0,
    title: Row(
      children: <Widget>[
        Expanded(
          child: Row(
            spacing: 6.0,
            children: <Widget>[
              Flexible(
                child: Text(
                  _title,
                  style: TextStyles.font14Weight700,
                ),
              ),
              if(_isExclusive)
                const ExclusiveOptionMarker()
            ],
          ),
        ),
        if(_price != null)
          Text(
            "(+ $_price ${context.l10n.pound})",
            style: const TextStyle(
              color: Colors.grey,

            ),
          )
      ],
    ),
  );
}
