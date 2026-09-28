import 'package:electronic_menu/features/root/presentation/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../root/domain/entities/item_entity.dart';
import '../widgets/additions_field.dart';
import '../widgets/amount_field.dart';
import '../widgets/notes_field.dart';
import '../widgets/order_bottom_bar.dart';
import '../widgets/order_title_and_description.dart';

final class NewOrderPage extends StatefulWidget {
  final ItemEntity _product;

  const new(this._product, {super.key});

  @override
  State<NewOrderPage> createState() => _NewOrderPageState();
}

class _NewOrderPageState extends State<NewOrderPage> {
  final ValueNotifier<int?> _amountController = ValueNotifier<int?>(null);
  final TextEditingController _notesController = TextEditingController();
  final ValueNotifier<int> _quantityController = ValueNotifier<int>(1);

  @override
  void dispose(){
    _notesController.dispose();
    _quantityController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    body: CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const .only(
            bottom: 12.0
          ),
          sliver: DefaultAppBar(imageUrl: widget._product.image)
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const .all(pageContentPadding),
            child: Column(
              crossAxisAlignment: .start,
              children: <Widget>[
                OrderTitleAndDescription(
                  title: widget._product.name,
                  description: widget._product.description,
                ),
                const SizedBox(height: 24.0),
                if(widget._product.sizes.isNotEmpty)
                  Padding(
                    padding: const .only(bottom: 8.0),
                    child: AmountField(
                      controller: _amountController,
                      title: context.l10n.chooseQuantityToAdd,
                      sizes: widget._product.sizes
                    ),
                  ),
                if(widget._product.obligatoryAddons.isNotEmpty)
                  Padding(
                    padding: const .only(bottom: 8.0),
                    child: AdditionsField(
                      title: context.l10n.paidAdditions,
                      addons: widget._product.obligatoryAddons,
                    ),
                  ),
                if(widget._product.optionalAddons.isNotEmpty)
                  Padding(
                    padding: const .only(bottom: 8.0),
                    child: AdditionsField(
                      title: context.l10n.freeAdditions,
                      addons: widget._product.optionalAddons
                    ),
                  ),
                NotesField(_notesController)
              ],
            ),
          ),
        )
      ],
    ),
    bottomNavigationBar: OrderBottomBar(
      quantityController: _quantityController,
      unitPrice: 250.0,
      cartImage: widget._product.image,
      onAddToOrder: () => Navigator.pop<bool>(context, true),
      onViewCart: () => Navigator.pushNamed(context, Routes.payment),
    ),
  );
}