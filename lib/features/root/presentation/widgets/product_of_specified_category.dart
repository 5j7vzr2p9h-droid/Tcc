import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/item_entity.dart';
import 'add_to_cart_button.dart';
import '../../../../core/widgets/product_placeholder.dart';

class ProductOfSpecifiedCategory extends StatelessWidget {
  final ItemEntity _product;

  const new(this._product, {super.key});

  @override
  Container build(BuildContext context)
  => Container(
    padding: const .all(4.0),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onPrimary,
      borderRadius: .circular(16.0)
    ),
    child: SizedBox(
      height: 100.0,
      child: Row(
        spacing: 8.0,
        children: <Widget>[
          ClipRRect(
            borderRadius: const .all(.circular(16.0)),
            child: CachedNetworkImage(
              imageUrl: _product.image,
              width: MediaQuery.widthOf(context)*0.3,
              memCacheWidth: (MediaQuery.widthOf(context)*0.3).toInt(),
              maxWidthDiskCache: (MediaQuery.widthOf(context)*0.3).toInt(),
              color: Colors.grey.shade300,
              colorBlendMode: .dstOver,
              fit: .cover,
              errorWidget: (BuildContext context, String url, Object error)
              => const ProductPlaceholder(),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .center,
              children: <Widget>[
                Text(
                  _product.name,
                  style: TextStyles.font18Weight700
                ),
                Text(
                  _product.description,
                  overflow: .ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.grey.shade600
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  _product.price.toString(),
                  style: TextStyles.font18Weight700,
                )
              ],
            ),
          ),
          Align(
            alignment: .bottomCenter,
            child: Padding(
              padding: const .all(4.0),
              child: AddToCartButton(
                product: _product,
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          )
        ],
      ),
    ),
  );
}