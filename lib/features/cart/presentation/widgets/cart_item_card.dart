import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/handled_network_image.dart';
import '../../../../core/widgets/quantity_stepper.dart';
import '../../../root/domain/entities/item_entity.dart';
import '../../domain/entities/cart_item_entity.dart';

final class CartItemCard extends StatefulWidget {
  final CartItemEntity _item;
  final ValueChanged<int> _onQuantityChanged;
  final VoidCallback _onDeletePressed;

  const new({
    super.key,
    required this._item,
    required this._onQuantityChanged,
    required this._onDeletePressed
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  late final ValueNotifier<int> _quantityController = ValueNotifier<int>(widget._item.quantity)
    ..addListener(_onQuantityChanged);

  @override
  void didUpdateWidget(CartItemCard oldWidget){
    super.didUpdateWidget(oldWidget);
    _quantityController.value = widget._item.quantity;
  }

  @override
  void dispose(){
    _quantityController.dispose();
    super.dispose();
  }

  void _onQuantityChanged(){
    if(_quantityController.value != widget._item.quantity)
      widget._onQuantityChanged(_quantityController.value);
  }

  String get _details{
    final List<String> details = <String>[
      ?widget._item.size?.name,
      ...widget._item.addons.map<String>((AddonEntity addon) => addon.name),
      ...widget._item.freeAdditions.map<String>((NoteEntity note) => note.name)
    ];
    return details.isEmpty ? widget._item.description : details.join(" • ");
  }

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
            imageUrl: widget._item.image,
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
                    Text(widget._item.name, style: TextStyles.font18Weight700),
                    Text(
                      _details,
                      maxLines: 2,
                      overflow: .ellipsis,
                      style: TextStyles.font14Weight400.copyWith(color: Colors.grey.shade600)
                    ),
                    Text(
                      "${widget._item.totalPrice.toStringAsFixed(0)} ${context.l10n.pound}",
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
                    onPressed: widget._onDeletePressed,
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
                    controller: _quantityController,
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
