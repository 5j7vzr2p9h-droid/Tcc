import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/enums/delivery_method.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../../delivery/domain/entities/address_entity.dart';
import '../../../delivery/presentation/viewmodels/saved_address_model/saved_addresses_cubit.dart';
import '../../../delivery/presentation/viewmodels/saved_address_model/saved_addresses_state.dart';
import '../../../delivery/presentation/widgets/address_card.dart';
import '../../../delivery/presentation/widgets/delivery_method_selector.dart';

final class DeliveryStep extends StatefulWidget {
  final ValueNotifier<DeliveryMethod> _methodController;
  final ValueNotifier<AddressEntity?> _addressController;

  const new({
    super.key,
    required this._methodController,
    required this._addressController
  });

  @override
  State<DeliveryStep> createState() => _DeliveryStepState();
}

class _DeliveryStepState extends State<DeliveryStep> {

  final ValueNotifier<int> _pickupPlaceController = ValueNotifier<int>(0);

  @override
  void dispose() {
    _pickupPlaceController.dispose();
    super.dispose();
  }

  void _addNewAddress() async{
    final bool? added = await Navigator.pushNamed<bool>(context, Routes.selectLocation, arguments: false);
    if(added == true && mounted)
      context.read<SavedAddressesCubit>().init();
  }

  Widget _buildAddresses()
  => BlocBuilder<SavedAddressesCubit, SavedAddressesState>(
    builder: (BuildContext context, SavedAddressesState state)
    => switch(state){
      SavedAddressesInitialState() || SavedAddressesLoadingState() => const Center(
        child: CircularProgressIndicator()
      ),
      SavedAddressesGetFailureState(:final Failure failure) => Center(
        child: FailurePlaceHolder(
          failure: failure,
          onRetry: context.read<SavedAddressesCubit>().init
        ),
      ),
      SavedAddressesGetSuccessState(:final List<AddressEntity> addresses) ||
      SetAsDefaultAddressSuccessState(:final List<AddressEntity> addresses) ||
      SetAsDefaultAdressFailureState(:final List<AddressEntity> addresses) => ValueListenableBuilder<AddressEntity?>(
        valueListenable: widget._addressController,
        builder: (BuildContext context, AddressEntity? selected, Widget? child)
        => RadioGroup<AddressEntity>(
          groupValue: selected,
          onChanged: (AddressEntity? address) => widget._addressController.value = address,
          child: Column(
            spacing: defaultItemsSeparator,
            children: <Widget>[
              for(final AddressEntity address in addresses) AddressCard(address: address)
            ],
          ),
        ),
      )
    }
  );

  @override
  SliverToBoxAdapter build(BuildContext context)
  => SliverToBoxAdapter(
    child: Padding(
      padding: const .all(pageContentPadding),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 16.0,
        children: <Widget>[
          Text("${context.l10n.chooseMethod}:", style: TextStyles.font16Weight700),
          DeliveryMethodSelector(controller: widget._methodController),
          Divider(
            height: 0.0,
            color: Theme.of(context).colorScheme.outline
          ),
          ValueListenableBuilder<DeliveryMethod>(
            valueListenable: widget._methodController,
            builder: (BuildContext context, DeliveryMethod method, Widget? child)
            => switch(method){
              .delivery => Column(
                crossAxisAlignment: .start,
                spacing: defaultItemsSeparator,
                children: <Widget>[
                  Text(
                    context.l10n.chooseAddress,
                    style: TextStyles.font16Weight700
                  ),
                  _buildAddresses(),
                  SizedBox(
                    width: double.infinity,
                    height: 48.0,
                    child: OutlinedButton.icon(
                      onPressed: _addNewAddress,
                      icon: const Icon(Icons.add_circle_outline),
                      label: Text(context.l10n.addNewAddress)
                    ),
                  ),
                ],
              ),
              .pickup => const SizedBox.shrink(),
            }
          ),
        ]
      ),
    ),
  );
}
