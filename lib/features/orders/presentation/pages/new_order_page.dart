import 'package:electronic_menu/features/root/presentation/widgets/default_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../core/widgets/handled_network_image.dart';
import '../../../cart/domain/entities/cart_item_entity.dart';
import '../../../cart/presentation/viewmodel/cart_cubit.dart';
import '../../../cart/presentation/viewmodel/cart_state.dart';
import '../../../root/domain/entities/item_entity.dart';
import '../widgets/additions_field.dart';
import '../widgets/amount_field.dart';
import '../widgets/conditional_group_field.dart';
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
  final ValueNotifier<Set<int>> _paidAddonsController = ValueNotifier<Set<int>>(const <int>{});
  final ValueNotifier<Set<int>> _freeAddonsController = ValueNotifier<Set<int>>(const <int>{});
  /// One per [ItemEntity.conditionalGroups], in the same order.
  late final List<ValueNotifier<Set<int>>> _conditionalGroupsControllers = List<ValueNotifier<Set<int>>>.generate(
    widget._product.conditionalGroups.length,
    (int _) => ValueNotifier<Set<int>>(const <int>{})
  );
  final TextEditingController _notesController = TextEditingController();
  final ValueNotifier<int> _quantityController = ValueNotifier<int>(1);

  @override
  void dispose(){
    _notesController.dispose();
    _quantityController.dispose();
    _amountController.dispose();
    _paidAddonsController.dispose();
    _freeAddonsController.dispose();
    for(final ValueNotifier<Set<int>> controller in _conditionalGroupsControllers)
      controller.dispose();
    super.dispose();
  }

  CartItemEntity get _cartItem{
    final ItemEntity product = widget._product;
    return CartItemEntity(
      productId: product.id,
      name: product.name,
      image: product.image,
      description: product.description,
      basePrice: product.price,
      size: _amountController.value == null ? null : product.sizes[_amountController.value!],
      addons: <AddonEntity>[
        for(final int i in _paidAddonsController.value) product.addons[i],
        for(final (int i, ConditionalGroupEntity group) in product.conditionalGroups.indexed)
          for(final int j in _conditionalGroupsControllers[i].value) group.options[j]
      ],
      freeAdditions: <NoteEntity>[
        for(final int i in _freeAddonsController.value) product.notes[i]
      ],
      notes: _notesController.text.trim(),
      quantity: _quantityController.value
    );
  }

  /// Stays 0 until a size is chosen, since the product price depends on it.
  double get _totalPrice => widget._product.sizes.isNotEmpty && _amountController.value == null
    ? 0.0
    : _cartItem.totalPrice;

  Future<void> _addToCart() async{
    if(widget._product.sizes.isNotEmpty && _amountController.value == null){
      SnackBarMessage.showErrorMessage(context, context.l10n.sizeIsRequired);
      return;
    }

    for(final (int i, ConditionalGroupEntity group) in widget._product.conditionalGroups.indexed)
      if(_conditionalGroupsControllers[i].value.length < group.minSelection){
        SnackBarMessage.showErrorMessage(context, context.l10n.minSelectionRequired(group.minSelection, group.name));
        return;
      }

    final CartCubit cartCubit = context.read<CartCubit>();
    await cartCubit.addToCart(_cartItem);

    if(!mounted) return;

    if(cartCubit.state case CartFailureState(:final Failure failure))
      SnackBarMessage.showErrorMessage(context, failure.mapFailureToMessage(context));
    else
      Navigator.pop<bool>(context, true);
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
          sliver: DefaultAppBar(
            background: Padding(
              padding: const .all(pageContentPadding),
              child: HandledNetworkImage(
                imageUrl: widget._product.image,
              ),
            ),
          )
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
                for(final (int i, ConditionalGroupEntity group) in widget._product.conditionalGroups.indexed)
                  Padding(
                    padding: const .only(bottom: 8.0),
                    child: ConditionalGroupField(
                      group: group,
                      controller: _conditionalGroupsControllers[i],
                    ),
                  ),
                if(widget._product.addons.isNotEmpty)
                  Padding(
                    padding: const .only(bottom: 8.0),
                    child: AdditionsField(
                      title: context.l10n.paidAdditions,
                      options: <({String name, double? price})>[
                        for(final AddonEntity addon in widget._product.addons) (name: addon.name, price: addon.price)
                      ],
                      controller: _paidAddonsController,
                    ),
                  ),
                if(widget._product.notes.isNotEmpty)
                  Padding(
                    padding: const .only(bottom: 8.0),
                    child: AdditionsField(
                      title: context.l10n.freeAdditions,
                      options: <({String name, double? price})>[
                        for(final NoteEntity note in widget._product.notes) (name: note.name, price: null)
                      ],
                      controller: _freeAddonsController,
                    ),
                  ),
                NotesField(_notesController)
              ],
            ),
          ),
        )
      ],
    ),
    bottomNavigationBar: ListenableBuilder(
      listenable: Listenable.merge(<Listenable>[
        _amountController,
        _paidAddonsController,
        _freeAddonsController,
        ..._conditionalGroupsControllers,
        _quantityController
      ]),
      builder: (BuildContext context, Widget? child) => OrderBottomBar(
        quantityController: _quantityController,
        totalPrice: _totalPrice,
        onAddToOrder: _addToCart,
        onViewCart: () => Navigator.pushNamed(context, Routes.payment),
      ),
    ),
  );
}
