import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/handled_network_image.dart';
import '../../domain/entities/favorite_food_entity.dart';
import 'favorite_button.dart';

final class FavoriteFoodCard extends StatelessWidget {
  static const double _borderRadiusValue = 12.0;

  final FavoriteFoodEntity _food;
  final VoidCallback _onTap, _onDeletePressed;

  const new({
    super.key,
    required this._food,
    required this._onTap,
    required this._onDeletePressed
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
                  imageUrl: _food.image,
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
                      _food.name,
                      style: TextStyles.font16Weight700
                    ),
                    Text(
                      _food.description,
                      style: TextStyles.font12Weight400.copyWith(color: Colors.grey),
                      maxLines: 2,
                      overflow: .ellipsis,
                    ),
                    Text(
                      "${_food.price.toStringAsFixed(2)} ${context.l10n.pound}",
                      style: TextStyles.font14Weight700.copyWith(
                        color: Theme.of(context).colorScheme.primary
                      )
                    )
                  ],
                ),
              ),
              FavoriteButton(
                (){}
              ),
            ],
          
          ),
        ),
      ),
    ),
  );
  // ListTile(
  //   onTap: _onTap,
  //   tileColor: Theme.of(context).colorScheme.surface,
  //   shape: RoundedRectangleBorder(borderRadius: .circular(16.0)),
  //   contentPadding: const .all(12.0),
  //   isThreeLine: true,
  //   leading: ClipRRect(
  //     borderRadius: .circular(12.0),
  //     child: Image.network(
  //       _food.image,
  //       width: 64.0,
  //       height: 64.0,
  //       fit: .cover,
  //       errorBuilder: (BuildContext context, Object _, StackTrace? _) => Container(
  //         width: 64.0,
  //         height: 64.0,
  //         color: Theme.of(context).colorScheme.outline,
  //         child: const Icon(Icons.fastfood_outlined),
  //       ),
  //     ),
  //   ),
  //   title: Row(
  //     children: <Widget>[
  //       Expanded(
  //         child: Text(
  //           _food.name,
  //           style: TextStyles.font16Weight700
  //         ),
  //       ),
  //       Icon(
  //         Icons.favorite,
  //         color: Theme.of(context).colorScheme.error
  //       )
  //     ],
  //   ),
  //   subtitle: Column(
  //     crossAxisAlignment: .start,
  //     spacing: 4.0,
  //     children: <Text>[
  //       Text(
  //         _food.description,
  //         maxLines: 2,
  //         overflow: .ellipsis,
  //         style: TextStyles.font12Weight400.copyWith(color: Colors.grey)
  //       ),
  //       Text(
  //         "${_food.price.toStringAsFixed(2)} ${context.l10n.pound}",
  //         style: TextStyles.font14Weight700.copyWith(
  //           color: Theme.of(context).colorScheme.primary
  //         )
  //       )
  //     ],
  //   ),
  //   trailing: OutlinedButton.icon(
  //     onPressed: _onDeletePressed,
  //     style: OutlinedButton.styleFrom(
  //       padding: const .symmetric(horizontal: 8.0),
  //       visualDensity: .compact,
  //       textStyle: TextStyles.font12Weight700
  //     ),
  //     icon: const Icon(Icons.delete_outline, size: 16.0),
  //     label: Text(context.l10n.delete)
  //   ),
  // );
}
