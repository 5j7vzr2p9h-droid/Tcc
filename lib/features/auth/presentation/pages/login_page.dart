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
import '../viewmodels/login_viewmodel/login_cubit.dart';
import '../viewmodels/login_viewmodel/login_state.dart';
import '../widgets/auth_divider.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_redirection.dart';
import '../widgets/auth_text_field.dart';

final class const LoginPage({super.key}) extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final class _LoginPageState extends State<LoginPage> {
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
    backgroundColor: Theme.of(context).colorScheme.surface,
    appBar: AppBar(),
    body: Form(
      key: _formKey,
      child: BlocProvider<LoginCubit>(
        create: (BuildContext context) => getIt<LoginCubit>(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (BuildContext context, LoginState state){
            if(state is LoginSuccessState)
              Navigator.pushNamed<void>(
                context,
                Routes.otpVerification,
                arguments: _phoneController.text
              );
            else if(state is LoginFailureState){
              SnackBarMessage.showErrorMessage(
                context,
                state.failure.mapFailureToMessage(context)
              );
            }
          },
          builder: (BuildContext context, LoginState state)
          => ListView(
            padding: const .all(pageContentPadding),
            children: <Widget>[
              AuthHeader(
                title: context.l10n.login,
                subtitle: context.l10n.loginSubtitle,
              ),
              const SizedBox(height: 60.0),
              AuthTextField(
                enabled: state is! LoginLoadingState,
                textController: _phoneController,
                label: context.l10n.phoneNumber,
                hint: context.l10n.enterPhoneNumber,
                icon: Icons.phone_outlined,
                keyboardType: .phone,
                validator: Validators.getPhoneNumberValidator(context),
              ),
              const SizedBox(height: 60.0),
              ElevatedButton(
                 onPressed: state is LoginLoadingState
                 ? null
                 : () {
                  if(_formKey.currentState!.validate())
                    context.read<LoginCubit>().login(phone: _phoneController.text.formatPhoneNumber);
                 },
                 child: Text(context.l10n.login)
               ),
              const SizedBox(height: 24.0),
              AuthDivider(label: context.l10n.or),
              const SizedBox(height: 24.0),
              AuthRedirection(
                question: context.l10n.dontHaveAccount,
                actionLabel: context.l10n.createAccount,
                onPressed: () => Navigator.of(context).pushNamed(Routes.register),
              ),
            ],
          )
        ),
      ),
    ),
  );
}