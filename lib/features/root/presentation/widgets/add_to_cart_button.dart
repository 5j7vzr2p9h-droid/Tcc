import 'package:flutter/material.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../domain/entities/item_entity.dart';

class AddToCartButton extends StatelessWidget {
  final ItemEntity _product;
  final Color? _backgroundColor, _foregroundColor;
  
  const new({
    required this._product,
    this._backgroundColor,
    this._foregroundColor,
    super.key
  });

  @override
  SizedBox build(BuildContext context)
  => SizedBox(
    height: 35.0, width: 35.0,
    child: IconButton(
      onPressed: () => func(context),
      style: IconButton.styleFrom(
        elevation: 4.0,
        shadowColor: Theme.of(context).colorScheme.shadow,
        padding: .zero,
        backgroundColor: _backgroundColor?? Theme.of(context).colorScheme.onPrimary,
        foregroundColor: _foregroundColor?? Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(12.0)
        )
      ),
      icon: const Icon(Icons.add)
    ),
  );

  void func (BuildContext context) async{
    final bool? result = await Navigator.pushNamed<bool>(
      context,
      Routes.newOrder,
      arguments: _product
    );
    if(result is bool && context.mounted)
      SnackBarMessage.showProductAddedMessage(context);
  }
}