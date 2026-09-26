import 'package:flutter/material.dart';

import '../extensions/context_l10n.dart';
import '../utils/text_styles.dart';
import 'handled_network_image.dart';

final class CartSummaryBar extends StatelessWidget {
  final String _image;
  final ValueNotifier<int> _itemsCountController;
  final double _unitPrice;
  final VoidCallback _onTap;

  const new({
    super.key,
    required this._image,
    required this._itemsCountController,
    required this._unitPrice,
    required this._onTap
  });

  @override
  ValueListenableBuilder<int> build(BuildContext context)
  => ValueListenableBuilder<int>(
    valueListenable: _itemsCountController,
    builder: (BuildContext context, int itemsCount, Widget? child)
    => InkWell(
      onTap: _onTap,
      borderRadius: .circular(16.0),
      child: Container(
        padding: const .symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: .circular(16.0)
        ),
        child: Row(
          spacing: 8.0,
          children: <Widget>[
            Stack(
              clipBehavior: .none,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const .all(.circular(10.0)),
                  child: HandledNetworkImage(
                    imageUrl: _image,
                    width: 36.0,
                    height: 36.0,
                  ),
                ),
                Positioned(
                  top: -6.0,
                  right: -6.0,
                  child: CircleAvatar(
                    radius: 8.0,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    child: Text(
                      "$itemsCount",
                      style: TextStyles.font12Weight700.copyWith(
                        color: Theme.of(context).colorScheme.onSurface
                      )
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: <Widget>[
                  Text(
                    context.l10n.viewCart,
                    style: TextStyles.font14Weight700.copyWith(color: Colors.white)
                  ),
                  Text(
                    "$itemsCount ${context.l10n.product}",
                    style: TextStyles.font12Weight400.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary
                    )
                  )
                ],
              ),
            ),
            Text(
              "${(_unitPrice * itemsCount).toStringAsFixed(2)} ${context.l10n.pound}",
              style: TextStyles.font14Weight700.copyWith(color: Colors.white)
            ),
            const Icon(Icons.chevron_right, color: Colors.white, size: 20.0)
          ],
        ),
      ),
    ),
  );
}
