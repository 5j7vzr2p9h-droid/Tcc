import 'package:flutter/material.dart';

import '../../../root/domain/entities/item_entity.dart';
import 'food_addition_tile.dart';
import 'order_field_title.dart';

final class AdditionsField extends StatelessWidget {
  final String _title;
  final List<AddonEntity> _addons;

  const new({
    super.key,
    required this._title,
    required this._addons
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
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: .zero,
          itemCount: _addons.length,
          separatorBuilder: (BuildContext _, int _) => Divider(
            color: Theme.of(context).colorScheme.outline,
            height: 1.0,
          ),
          itemBuilder: (BuildContext context, int i) => FoodAdditionTile(
            title: _addons[i].name,
            price: _addons[i].price,
            controller: ValueNotifier<bool>(true)
          ),
        ),
      )
    ],
  );
}