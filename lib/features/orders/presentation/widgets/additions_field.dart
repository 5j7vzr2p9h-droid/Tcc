import 'package:flutter/material.dart';

import 'food_addition_tile.dart';
import 'order_field_title.dart';

final class AdditionsField extends StatelessWidget {
  final String _title;
  /// [price] is null for free additions.
  final List<({String name, double? price})> _options;
  /// Indexes of the selected [_options].
  final ValueNotifier<Set<int>> _controller;

  const new({
    super.key,
    required this._title,
    required this._options,
    required this._controller
  });

  @override
  Column build(BuildContext context)
  => Column(
    children: <Widget>[
      OrderFieldTitle(
        title: _title
      ),
      const SizedBox(height: 4.0),
      Material(
        clipBehavior: .antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(16.0),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline
          ),
        ),
        child: ValueListenableBuilder<Set<int>>(
          valueListenable: _controller,
          builder: (BuildContext context, Set<int> selectedIndexes, Widget? child)
          => ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: .zero,
            itemCount: _options.length,
            separatorBuilder: (BuildContext _, int _) => Divider(
              color: Theme.of(context).colorScheme.outline,
              height: 1.0,
            ),
            itemBuilder: (BuildContext context, int i) => FoodAdditionTile(
              title: _options[i].name,
              price: _options[i].price,
              value: selectedIndexes.contains(i),
              onChanged: (bool isSelected) => _controller.value = isSelected
                ? <int>{...selectedIndexes, i}
                : (<int>{...selectedIndexes}..remove(i))
            ),
          ),
        ),
      )
    ],
  );
}
