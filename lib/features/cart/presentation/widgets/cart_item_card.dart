import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/handled_network_image.dart';
import '../../../../core/widgets/quantity_stepper.dart';
import '../../domain/entities/cart_item_entity.dart';

final class CartItemCard extends StatelessWidget {
  final CartItemEntity _item;

  const new({
    super.key,
    required this._item,
  });

  @override
  Container build(BuildContext context)
  => Container(
    padding: const .all(12.0),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: .circular(16.0)
    ),
    child: Row(
      spacing: 16.0,
      children: [
        ClipRRect(
          borderRadius: const .all(.circular(12.0)),
          child: HandledNetworkImage(
            imageUrl: _item.image,
            width: 120.0,
            height: 120.0,
          ),
        ),
        Expanded(
          child: Column(
            spacing: 16.0,
            children: <Widget>[
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 20.0
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 4.0,
                  children: <Widget>[
                    Text(_item.name, style: TextStyles.font18Weight700),
                    Text(
                      _item.description,
                      maxLines: 2,
                      overflow: .ellipsis,
                      style: TextStyles.font14Weight400.copyWith(color: Colors.grey.shade600)
                    ),
                    Text(
                      "${_item.price.toStringAsFixed(0)} ${context.l10n.pound}",
                      style: TextStyles.font16Weight700.copyWith(
                        color: Theme.of(context).colorScheme.primary
                      )
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: (){},
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: .circular(12.0)
                      )
                    ),
                    icon: const Icon(Icons.delete_outline)
                  ),
                  QuantityStepper(
                    controller: ValueNotifier(2),
                  )
                ],
              )
            ],
          ),
        )
      ],
    )
  );
}
