import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';
import '../../domain/entities/item_entity.dart';
import 'add_to_cart_button.dart';

final class ItemCard extends StatelessWidget {
  final ItemEntity _product;

  const new(this._product, {super.key,});

  @override
  Container build(BuildContext context)
  => Container(
    decoration: BoxDecoration(
      borderRadius: .circular(12.0),
      color: Colors.white
    ),
    clipBehavior: .antiAliasWithSaveLayer,
    child: Column(
      crossAxisAlignment: .start,
      children: [
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children: <Widget>[
            ClipRRect(
              borderRadius: const .all(.circular(12.0)),
              child: CachedNetworkImage(
                imageUrl: _product.image,
                height: 100.0,
                width: .infinity,
                fit: .cover,
              ),
            ),
            IconButton(
              onPressed: (){

              },
              icon: const Icon(Icons.favorite_outline, color: Colors.grey)
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: .center,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: 4.0,
                  children: <Text>[
                    Text(
                      _product.name,
                      style: TextStyles.font14Weight700,
                      overflow: .ellipsis,
                    ),
                    Text(
                      _product.price.toString(),
                      style: TextStyles.font12Weight700.copyWith(
                        color: Theme.of(context).primaryColor
                      ),
                    )
                  ],
                ),
              ),
              AddToCartButton(
                product: _product,
              )
            ],
          ),
        )
      ],
    ),
  );
}