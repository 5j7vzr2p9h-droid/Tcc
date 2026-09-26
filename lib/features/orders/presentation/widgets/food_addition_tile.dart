import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class FoodAdditionTile extends StatefulWidget {
  final String _title;
  final double? _price;
  final ValueNotifier<bool> _controller;

  const new({
    super.key,
    required this._title,
    this._price,
    required this._controller
  });

  @override
  State<FoodAdditionTile> createState() => _FoodAdditionTileState();
}

class _FoodAdditionTileState extends State<FoodAdditionTile> {

  @override
  ValueListenableBuilder<bool> build(BuildContext context)
  => ValueListenableBuilder(
    valueListenable: widget._controller,
    builder: (BuildContext context, bool value, Widget? child) => CheckboxListTile(
      onChanged: (bool? newValue) => widget._controller.value = newValue!,
      value: value,
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
            child: Text(
              widget._title,
              style: TextStyles.font14Weight700,
            ),
          ),
          if(widget._price != null)
            Text(
              "(+ ${widget._price} ${context.l10n.pound})",
              style: const TextStyle(
                color: Colors.grey,
                
              ),
            )
        ],
      ),
    ),
  );
}