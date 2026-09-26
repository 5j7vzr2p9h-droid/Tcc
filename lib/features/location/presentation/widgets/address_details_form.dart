import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../di.dart';
import '../../../delivery/presentation/widgets/address_dropdown_field.dart';
import '../../../delivery/presentation/widgets/address_text_field.dart';
import '../../../delivery/presentation/widgets/primary_address_switch.dart';
import '../viewmodels/address_details_viewmodel/address_details_cubit.dart';
import '../viewmodels/address_details_viewmodel/address_details_state.dart';

final class AddressDetailsForm extends StatefulWidget {


  const new({super.key});

  @override
  State<AddressDetailsForm> createState() => _AddressDetailsFormState();
}

final class _AddressDetailsFormState extends State<AddressDetailsForm> {
  final TextEditingController _notesController = TextEditingController();
  final ValueNotifier<bool> _isPrimaryController = ValueNotifier<bool>(true);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose(){
    _notesController.dispose();
    _isPrimaryController.dispose();
    super.dispose();
  }

  @override
  Padding build(BuildContext context)
  => Padding(
    padding: const .all(pageContentPadding),
    child: BlocProvider<AddressDetailsCubit>(
      create: (BuildContext _) => getIt<AddressDetailsCubit>()..getRegions(),
      child: BlocConsumer<AddressDetailsCubit, AddressDetailsState>(
        listener: (BuildContext context, AddressDetailsState state){
          if(state is AddressDetailsFailureState){
            Navigator.pop(context);
            SnackBarMessage.showErrorMessage(
              context,
              state.failure.mapFailureToMessage(context)
            );
          }
        },
        builder: (BuildContext context, AddressDetailsState state)
        => switch(state){
          AddressDetailsInitialState() || AddressDetailsFailureState() => const SizedBox.shrink(),
          AddressDetailsLoadingState() => const Center(child: CircularProgressIndicator()),
          AddressDetailsSuccessState() => Form(
            key: _formKey,
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .stretch,
              spacing: 16.0,
              children: <Widget>[
                AddressDropdownField(
                  (String? value){
          
                  }
                ),
                AddressTextField(
                  textController: _notesController,
                  linesNumber: 3,
                  label: context.l10n.detailedAddress,
                  hint: context.l10n.additionalNotesHint,
                  icon: Icons.edit_note,
                ),
                PrimaryAddressSwitch(controller: _isPrimaryController),
                ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
          
                    }
                  },
                  child: Text(context.l10n.confirmAddress)
                )
              ],
            ),
          ),
        } 
      ),
    )
  );
}