import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../di.dart';
import '../../../delivery/presentation/widgets/address_text_field.dart';
import '../../../delivery/presentation/widgets/primary_address_switch.dart';
import '../viewmodels/address_details_viewmodel/address_details_cubit.dart';
import '../viewmodels/address_details_viewmodel/address_details_state.dart';

final class const AddressDetailsForm({
  super.key,
  required final double _lat,
  required final double _lng
}) extends StatefulWidget {

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
      create: (BuildContext _) => getIt<AddressDetailsCubit>(),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .stretch,
            spacing: 16.0,
            children: <Widget>[
              AddressTextField(
                textController: _notesController,
                linesNumber: 3,
                label: context.l10n.detailedAddress,
                hint: context.l10n.additionalNotesHint,
                icon: Icons.edit_note,
              ),
              PrimaryAddressSwitch(controller: _isPrimaryController),
              BlocProvider<AddressDetailsCubit>(
                create: (BuildContext _) => getIt<AddressDetailsCubit>(),
                child: BlocConsumer<AddressDetailsCubit, AddressDetailsState>(
                  listener: (BuildContext context, AddressDetailsState state){
                    if(state is AddAddressFailureState){
                      Navigator.pop(context);
                      SnackBarMessage.showErrorMessage(
                        context,
                        state.failure.mapFailureToMessage(context)
                      );
                    }
                    else if(state is AddAddressSuccessState)
                      Navigator.pop(context, true);
                  },
                  builder: (BuildContext context, AddressDetailsState state)
                  => ElevatedButton(
                    onPressed: state is AddingAddressState
                      ? null
                      : () {
                      if(_formKey.currentState!.validate()){
                        context.read<AddressDetailsCubit>().addAddress(
                          addressText: _notesController.text,
                          isDefault: _isPrimaryController.value,
                          lat: widget._lat,
                          lng: widget._lng
                        );
                      }
                    },
                    child: Text(context.l10n.confirmAddress)
                  )
                ),
              )
            ],
          ),
        ),
    )
  );
}