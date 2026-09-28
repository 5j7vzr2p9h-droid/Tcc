import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/handled_network_image.dart';
import '../../../root/domain/entities/item_entity.dart';
import 'favorite_button.dart';

final class FavoriteItemCard extends StatelessWidget {
  static const double _borderRadiusValue = 12.0;

  final ItemEntity _product;
  final VoidCallback _onTap, _onRemoved;

  const new({
    super.key,
    required this._product,
    required this._onTap,
    required this._onRemoved
  });

  @override
  Material build(BuildContext context)
  => Material(
    borderRadius: const .all(Radius.circular(_borderRadiusValue)),
    clipBehavior: .antiAliasWithSaveLayer,
    child: InkWell(
      borderRadius: const .all(.circular(_borderRadiusValue)),
      onTap: _onTap,
      child: SizedBox(
        height: 130.0,
        child: Padding(
          padding: const .all(8.0),
          child: Row(
            crossAxisAlignment: .start,
            spacing: 12.0,
            children: <Widget>[
              ClipRRect(
                borderRadius: const .all(.circular(_borderRadiusValue)),
                child: HandledNetworkImage(
                  imageUrl: _product.image,
                  width: 120.0,
                  height: 130.0,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .center,
                  spacing: 4.0,
                  children: <Widget>[
                    Text(
                      _product.name,
                      style: TextStyles.font16Weight700
                    ),
                    Text(
                      _product.description,
                      style: TextStyles.font12Weight400.copyWith(color: Colors.grey),
                      maxLines: 2,
                      overflow: .ellipsis,
                    ),
                    Text(
                      "${_product.price.toStringAsFixed(2)} ${context.l10n.pound}",
                      style: TextStyles.font14Weight700.copyWith(
                        color: Theme.of(context).colorScheme.primary
                      )
                    )
                  ],
                ),
              ),
              FavoriteButton(
                key: ValueKey<int>(_product.id),
                productId: _product.id,
                isFavorite: true,
                onChanged: (bool isFavorite){
                  if(!isFavorite) _onRemoved();
                },
              ),
            ],
          
          ),
        ),
      ),
    ),
  );
}