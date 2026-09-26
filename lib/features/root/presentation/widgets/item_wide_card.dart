import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/item_entity.dart';
import 'add_to_cart_button.dart';

final class ItemWideCard extends StatelessWidget {
  final ItemEntity _product;

  const new(this._product, {super.key});

  @override
  Container build(BuildContext context)
  => Container(
    padding: const .all(8.0),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onPrimary,
      borderRadius: .circular(16.0)
    ),
    child: SizedBox(
      height: 100.0,
      child: Row(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: _product.image,
            width: 100.0,
            maxWidthDiskCache: 100,
            memCacheWidth: 100,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  _product.name,
                  style: TextStyles.font18Weight700
                ),
                Text(
                  _product.description,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.grey.shade600
                  ),
                ),
                const SizedBox(height: defaultItemsSeparator),
                Text(
                  _product.price.toString(),
                  style: TextStyles.font14Weight700.copyWith(
                    color: Theme.of(context).colorScheme.primary
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: .spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: (){},
                style: IconButton.styleFrom(tapTargetSize: .shrinkWrap),
                icon: const Icon(Icons.favorite_outline)
              ),
              AddToCartButton(
                product: _product,
              )
            ],
          )
        ],
      ),
    ),
  );
}