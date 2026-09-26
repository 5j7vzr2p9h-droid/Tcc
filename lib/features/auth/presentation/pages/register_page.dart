import 'package:electronic_menu/core/extensions/failure_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/format_phone_number.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../core/utils/validators.dart';
import '../../../../di.dart';
import '../viewmodels/register_viewmodel/register_cubit.dart';
import '../viewmodels/register_viewmodel/register_state.dart';
import '../widgets/auth_divider.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_redirection.dart';
import '../widgets/auth_terms_note.dart';
import '../widgets/auth_text_field.dart';

final class const RegisterPage({
  super.key,
  required final String _logoUrl
}) extends StatefulWidget {

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(),
    _phoneController = TextEditingController(),
    _addressController = TextEditingController();

  @override
  void dispose(){
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    backgroundColor: Theme.of(context).colorScheme.surface,
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: IconButton(
        onPressed: () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back)
      ),
    ),
    body: Form(
      key: _formKey,
      child: BlocProvider<RegisterCubit>(
        create: (BuildContext context) => getIt<RegisterCubit>(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (BuildContext context, RegisterState state){
            if(state is RegisterSuccessState)
              Navigator.of(context).pushNamed(
                Routes.otpVerification,
                arguments: _phoneController.text
              );
            else if(state is RegisterFailureState)
              SnackBarMessage.showErrorMessage(
                context,
                state.failure.mapFailureToMessage(context)
              );
          },
          builder: (BuildContext context, RegisterState state)
          => ListView(
            padding: const .all(pageContentPadding),
            children: <Widget>[
              AuthHeader(
                title: context.l10n.createAccount,
                subtitle: context.l10n.createAccountSubtitle,
              ),
              const SizedBox(height: 60.0),
              AuthTextField(
                enabled: state is! RegisterLoadingState,
                textController: _nameController,
                label: context.l10n.name,
                hint: context.l10n.enterFullName,
                icon: Icons.person_outline_rounded,
                keyboardType: .name,
                validator: Validators.getNameValidator(context),
              ),
              const SizedBox(height: 24.0),
              AuthTextField(
                enabled: state is! RegisterLoadingState,
                textController: _phoneController,
                label: context.l10n.phoneNumber,
                hint: context.l10n.enterPhoneNumber,
                icon: Icons.phone_outlined,
                keyboardType: .phone,
                validator: Validators.getPhoneNumberValidator(context),
              ),
              const SizedBox(height: 24.0),
              AuthTextField(
                enabled: state is! RegisterLoadingState,
                textController: _addressController,
                label: context.l10n.address,
                hint: context.l10n.enterAddress,
                icon: Icons.location_on_outlined,
                keyboardType: .streetAddress,
                validator: Validators.getAuthAddressValidator(context),
              ),
              const SizedBox(height: 60.0),
              ElevatedButton(
                onPressed: state is RegisterLoadingState
                ? null
                : (){
                  if(_formKey.currentState!.validate())
                    context.read<RegisterCubit>().register(
                      name: _nameController.text,
                      phone: _phoneController.text.formatPhoneNumber,
                      address: _addressController.text
                    );
                },
                child: Text(context.l10n.createAccount)
              ),
              const SizedBox(height: 24.0),
              AuthDivider(label: context.l10n.or),
              const SizedBox(height: 24.0),
              AuthRedirection(
                question: context.l10n.alreadyHaveAccount,
                actionLabel: context.l10n.login,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
              const SizedBox(height: 16.0),
              const AuthTermsNote()
            ],
          )
        ),
      ),
    ),
  );
}
