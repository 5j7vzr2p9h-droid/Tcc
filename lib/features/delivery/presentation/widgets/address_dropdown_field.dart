import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/utils/validators.dart';

final class AddressDropdownField extends StatelessWidget {
  final ValueSetter<String?> _setter;
  const new(this._setter, {super.key});

  @override
  Column build(BuildContext context)
  => Column(
    crossAxisAlignment: .start,
    mainAxisSize: .min,
    spacing: 8.0,
    children: <Widget>[
      Text(context.l10n.regionName, style: TextStyles.font14Weight700),
      DropdownButtonFormField<String>(
        validator: Validators.getRegionDropdownValidator(context),
        items: const <DropdownMenuItem<String>>[
          DropdownMenuItem<String>(
            value: "المشحمة",
            child: Text("المشحمة")
          )
        ],
        isExpanded: true,
        hint: Text(
          context.l10n.region,
          style: Theme.of(context).inputDecorationTheme.hintStyle
        ),
        onChanged: _setter,
        decoration: InputDecoration(
          contentPadding: const .symmetric(
            horizontal: 12.0,
            vertical: 16.0
          ),
          prefixIcon: Icon(
            Icons.location_on_outlined,
            color: Theme.of(context).colorScheme.primary
          )
        ),
      ),
    ],
  );
}