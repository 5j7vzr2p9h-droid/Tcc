import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../di.dart';
import '../viewmodels/verify_phone_viewmodel/verify_phone_cubit.dart';
import '../viewmodels/verify_phone_viewmodel/verify_phone_state.dart';
import '../widgets/otp_field.dart';
import '../widgets/otp_resend_timer.dart';
import '../widgets/otp_target_note.dart';

final class const OtpVerificationPage(final String _phoneNumber, {super.key}) extends StatefulWidget {

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  static const bool _isWrongOtp = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose(){
    _codeController.dispose();
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
      child: BlocProvider<VerifyPhoneCubit>(
        create: (BuildContext context) => getIt<VerifyPhoneCubit>(),
        child: BlocConsumer<VerifyPhoneCubit, VerifyPhoneState>(
          listener: (BuildContext context, VerifyPhoneState state){
            if(state is VerifyPhoneSuccessState)
              Navigator.pushReplacementNamed(context, Routes.main);
            else if(state is VerifyPhoneFailureState)
              SnackBarMessage.showErrorMessage(context, state.failure.mapFailureToMessage(context));
            else if(state is ResendOtpSuccessState)
              SnackBarMessage.showSuccessMessage(context, state.message);
            else if(state is ResendOtpFailureState)
              SnackBarMessage.showErrorMessage(context, state.failure.mapFailureToMessage(context));
          },
          builder: (BuildContext context, VerifyPhoneState state)
          => ListView(
              padding: const .all(pageContentPadding),
              children: <Widget>[
                _isWrongOtp?
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.errorContainer,
                      radius: 48.0,
                      child: SvgPicture.asset(
                        AssetsManager.declined,
                        width: 64.0,
                      )
                    )
                  ):
                  const Center(
                    child: Image(
                      image: AssetImage(AssetsManager.logo),
                      width: 200.0,
                    ),
                  ),
                const SizedBox(height: 60.0),
                Text(
                  _isWrongOtp? context.l10n.otpErrorTitle: context.l10n.verifyPhoneNumber,
                  textAlign: .center,
                  style: TextStyles.font24Weight700
                ),
                const SizedBox(height: 8.0),
                if(_isWrongOtp)
                  Text(
                    context.l10n.otpErrorMessage,
                    textAlign: .center,
                    style: TextStyles.font14Weight400.copyWith(color: Colors.grey)
                  )
                else ...[
                  Text(
                      context.l10n.enterVerificationCode,
                    textAlign: .center,
                    style: TextStyles.font14Weight400.copyWith(color: Colors.grey)
                  ),
                  const SizedBox(height: 4.0),
                  OtpTargetNote(
                    phoneNumber: widget._phoneNumber,
                    onChangeNumber: () => Navigator.of(context).maybePop(),
                  )
                ],
                const SizedBox(height: 40.0),
                OtpField(
                  textController: _codeController,
                  onCompleted: (){},
                ),
                const SizedBox(height: 40.0),
                OtpResendTimer(
                  onResend: () => context.read<VerifyPhoneCubit>().resendOtp(widget._phoneNumber)
                ),
                const SizedBox(height: 60.0),
                ElevatedButton(
                  onPressed: state is VerifyPhoneLoadingState
                  ? null
                  : () => context.read<VerifyPhoneCubit>().verifyPhone(phone: widget._phoneNumber, code: _codeController.text),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder()
                  ),
                  child: Text(_isWrongOtp? context.l10n.tryAgain: context.l10n.confirm)
                )
              ],
            )
        ),
      ),
    ),
  );

  // void _verify() => _formKey.currentState!.validate()?
  //   Navigator.of(context).pushNamedAndRemoveUntil(
  //     Routes.main,
  //     (Route<dynamic> _) => false
  //   ):
  // SnackBarMessage.showErrorMessage(
  //   context,
  //   context.l10n.otpErrorSnackbarMessage
  // );
}