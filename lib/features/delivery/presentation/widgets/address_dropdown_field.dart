import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../location/domain/entities/region_entity.dart';

final class const AddressDropdownField({
  super.key,
  required final List<RegionEntity> _regions,
  required final ValueNotifier<int?> _regionController
}) extends StatelessWidget {

  @override
  Column build(BuildContext context)
  => Column(
    crossAxisAlignment: .start,
    mainAxisSize: .min,
    spacing: 8.0,
    children: <Widget>[
      Text(context.l10n.regionName, style: TextStyles.font14Weight700),
      DropdownButtonFormField<int>(
        validator: Validators.getRegionDropdownValidator(context),
        items: <DropdownMenuItem<int>>[
          for(final RegionEntity region in _regions)
            DropdownMenuItem<int>(
              value: region.id,
              child: Text(region.title)
            )
        ],
        hint: Text(
          context.l10n.region,
          style: Theme.of(context).inputDecorationTheme.hintStyle
        ),
        onChanged: (int? id) => _regionController.value = id,
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