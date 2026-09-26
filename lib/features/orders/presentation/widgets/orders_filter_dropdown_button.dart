import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class OrdersFilterDropdownButton extends StatelessWidget {
  static const List<String> filters = <String>[
    "الكل",
    "مكتمل",
    "ملغي"
  ];

  final ValueNotifier<String> _selectedFilter;

  const new({
    super.key,
    required this._selectedFilter,
  });

  @override
  ValueListenableBuilder<String> build(BuildContext context)
  => ValueListenableBuilder<String>(
    valueListenable: _selectedFilter,
    builder: (BuildContext context, String selected, Widget? child)
    => DropdownButton<String>(
      value: selected,
      isDense: true,
      underline: const SizedBox.shrink(),
      borderRadius: const .all(.circular(12.0)),
      style: TextStyles.font16Weight700.copyWith(
        color: Theme.of(context).colorScheme.onSurface
      ),
      icon: const Icon(Icons.keyboard_arrow_down),
      onChanged: (String? filter) => _selectedFilter.value = filter ?? selected,
      items: <DropdownMenuItem<String>>[
        for(final String filter in <String>[context.l10n.all, context.l10n.completed, context.l10n.canceled])
          DropdownMenuItem<String>(
            value: filter,
            child: Text(filter)
          )
      ],
    ),
  );
}
