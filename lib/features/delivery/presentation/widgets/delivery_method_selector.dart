import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/enums/delivery_method.dart';
import '../../../../core/utils/text_styles.dart';

final class DeliveryMethodSelector extends StatelessWidget {
  final ValueNotifier<DeliveryMethod> _controller;

  const new({
    super.key,
    required this._controller
  });

  @override
  ValueListenableBuilder<DeliveryMethod> build(BuildContext context)
  => ValueListenableBuilder<DeliveryMethod>(
    valueListenable: _controller,
    builder: (BuildContext context, DeliveryMethod selected, Widget? child)
    => Row(
      spacing: defaultItemsSeparator,
      children: <Widget>[
        for(final DeliveryMethod method in DeliveryMethod.values) Expanded(
          child: DeliveryMethodOption(
            method: method,
            selected: selected == method,
            onSelected: () => _controller.value = method,
          ),
        )
      ],
    ),
  );
}

final class DeliveryMethodOption extends StatelessWidget {
  final DeliveryMethod _method;
  final bool _selected;
  final VoidCallback _onSelected;

  const new({
    super.key,
    required this._method,
    required this._selected,
    required this._onSelected
  });

  String get _label => switch(_method){
    .delivery => "توصيل للمنزل",
    .pickup => "استلام فرع"
  };

  @override
  Material build(BuildContext context)
  => Material(
    borderRadius: .circular(12.0),
    child: CheckboxListTile(
      value: _selected,
      onChanged: (bool? value) => _onSelected(),
      selected: _selected,
      controlAffinity: .leading,
      activeColor: Theme.of(context).colorScheme.primary,
      contentPadding: const .symmetric(horizontal: 8.0, vertical: 12.0),
      dense: true,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity
      ),
      materialTapTargetSize: .shrinkWrap,
      minVerticalPadding: 0.0,
      minLeadingWidth: 0.0,
      horizontalTitleGap: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12.0),
        side: BorderSide(
          color: _selected? Theme.of(context).colorScheme.primary: Theme.of(context).colorScheme.outline,
          width: _selected? 2.0: 1.0
        )
      ),
      title: Text(_label, style: TextStyles.font14Weight700),
    ),
  );
}