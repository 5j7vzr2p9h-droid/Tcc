import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/extensions/format_phone_number.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../core/utils/validators.dart';
import '../../../../di.dart';
import '../../../auth/presentation/widgets/auth_text_field.dart';
import '../viewmodel/edit_phone_viewmodel/edit_phone_cubit.dart';
import '../viewmodel/edit_phone_viewmodel/edit_phone_state.dart';

final class const EditPhonePage({super.key}) extends StatefulWidget {

  @override
  State<EditPhonePage> createState() => _EditPhonePageState();
}

final class _EditPhonePageState extends State<EditPhonePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  
  @override
  void dispose(){
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(),
    body: CustomScrollView(
      slivers: <Widget>[
        SliverFillRemaining(
          child:  Form(
            key: _formKey,
            child: Padding(
              padding: const .all(pageContentPadding),
              child: BlocProvider<EditPhoneCubit>(
                create: (BuildContext _) => getIt<EditPhoneCubit>(),
                child: BlocConsumer<EditPhoneCubit, EditPhoneState>(
                  listener: (BuildContext context, EditPhoneState state){
                    if(state is EditPhoneRequestFailureState)
                      SnackBarMessage.showErrorMessage(context, state.failure.mapFailureToMessage(context));
                    else if(state is EditPhoneRequestSuccessState)
                      Navigator.pushNamed(context, Routes.otpVerification, arguments: _phoneController.text);
                  },
                  builder: (BuildContext context, EditPhoneState state) => Column(
                    mainAxisSize: .min,
                    mainAxisAlignment: .center,
                    spacing: 60.0,
                    children: <Widget>[
                      AuthTextField(
                        enabled: state is! EditPhoneRequestingState,
                        textController: _phoneController,
                        label: context.l10n.phoneNumber,
                        hint: context.l10n.enterNewPhoneNumber,
                        icon: Icons.phone_outlined,
                        keyboardType: .phone,
                        autovalidateMode: .onUserInteraction,
                        validator: Validators.getPhoneNumberValidator(context),
                      ),
                      ElevatedButton(
                         onPressed: state is EditPhoneRequestingState
                         ? null
                         : () {
                          if(_formKey.currentState!.validate())
                            context.read<EditPhoneCubit>().requestPhoneUpdate(
                              _phoneController.text.formatPhoneNumber
                            );
                         },
                         child: Text(context.l10n.requestPhoneEdit)
                       ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}