import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/add_new_button.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../../../core/widgets/secured_info_footer.dart';
import '../../../../di.dart';
import '../../domain/entities/address_entity.dart';
import '../viewmodels/saved_address_model/saved_addresses_cubit.dart';
import '../viewmodels/saved_address_model/saved_addresses_state.dart';
import '../widgets/saved_address_card.dart';

final class const SavedAddressesPage({super.key}) extends StatelessWidget {

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(context.l10n.savedAddresses, style: TextStyles.font18Weight700),
    ),
    body: BlocProvider<SavedAddressesCubit>(
      create: (BuildContext context) => getIt<SavedAddressesCubit>()..init(),
      child: BlocConsumer<SavedAddressesCubit, SavedAddressesState>(
        listener: (BuildContext context, SavedAddressesState state){
          if(state is SetAsDefaultAdressFailureState)
            SnackBarMessage.showErrorMessage(context, state.failure.mapFailureToMessage(context));
          else if(state is DeleteAddressFailureState)
            SnackBarMessage.showErrorMessage(context, state.failure.mapFailureToMessage(context));
        },
        builder: (BuildContext context, SavedAddressesState state)
        => switch(state){
          SavedAddressesInitialState() => const SizedBox.shrink(),
          SavedAddressesLoadingState() => const Center(
            child: CircularProgressIndicator()
          ),
          SavedAddressesGetFailureState(:final Failure failure) => Center(
            child: FailurePlaceHolder(
              failure: failure,
              onRetry: context.read<SavedAddressesCubit>().init,
            ),
          ),
          SavedAddressesGetSuccessState(:final List<AddressEntity> addresses) ||
          SetAsDefaultAddressSuccessState(:final List<AddressEntity> addresses) ||
          SetAsDefaultAdressFailureState(:final List<AddressEntity> addresses) ||
          DeleteAddressSuccessState(:final List<AddressEntity> addresses) ||
          DeleteAddressFailureState(:final List<AddressEntity> addresses) => CustomScrollView(
            slivers: <Widget>[
              SliverPadding(
                padding: const .all(pageContentPadding),
                sliver: SliverList.separated(
                  itemCount: addresses.length,
                  separatorBuilder: (BuildContext _, int _)
                  => const SizedBox(height: defaultItemsSeparator,),
                  itemBuilder: (BuildContext context, int i)
                  => SavedAddressCard(
                    address: addresses[i],
                    onActionSelected: (SavedAddressAction action){
                      if(action == SavedAddressAction.setAsDefault)
                        context.read<SavedAddressesCubit>().setAsDefaultAddress(addresses[i].id);
                      if(action == SavedAddressAction.delete)
                        context.read<SavedAddressesCubit>().deleteAddress(addresses[i].id);
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const .only(
                    left: pageContentPadding,
                    right: pageContentPadding,
                    bottom: pageContentPadding
                  ),
                  child: Column(
                    spacing: defaultItemsSeparator,
                    crossAxisAlignment: .stretch,
                    mainAxisSize: .min,
                    children: <Widget>[
                      AddNewButton(
                        label: context.l10n.addNewAddress,
                        onPressed: () => Navigator.pushNamed(context, Routes.selectLocation),
                      ),
                      SecuredInfoFooter(message: context.l10n.addressesSecured)
                    ],
                  ),
                ),
              )
            ],
          ),
        }
      ),
    )
  );
}