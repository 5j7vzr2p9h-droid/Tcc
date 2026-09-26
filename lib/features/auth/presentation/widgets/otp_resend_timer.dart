import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class const OtpResendTimer({
  super.key,
  required final VoidCallback _onResend
}) extends StatefulWidget {

  @override
  State<OtpResendTimer> createState() => _OtpResendTimerState();
}

class _OtpResendTimerState extends State<OtpResendTimer> {
  static const Duration _timeToResend = Duration(seconds: 45);

  Timer? _timer;
  final ValueNotifier<int> _remainingSecondsController = ValueNotifier<int>(45);

  @override
  void initState(){
    super.initState();
    _restart();
  }

  @override
  void dispose(){
    _timer?.cancel();
    _remainingSecondsController.dispose();
    super.dispose();
  }

  @override
  Column build(BuildContext context)
  => Column(
    spacing: 4.0,
    children: <Widget>[
      Text(
        context.l10n.didntReceiveCode,
        style: TextStyles.font14Weight400.copyWith(color: Colors.grey)
      ),
      ValueListenableBuilder<int>(
        valueListenable: _remainingSecondsController,
        builder: (BuildContext context, int remainingSeconds, Widget? _)
        => remainingSeconds > 0
          ? Text.rich(
              TextSpan(
                style: TextStyles.font14Weight400.copyWith(color: Colors.grey),
                children: <InlineSpan>[
                  TextSpan(text: context.l10n.resendCodeIn),
                  TextSpan(
                    text: _formattedRemaining,
                    style: TextStyles.font14Weight700.copyWith(
                      color: Theme.of(context).colorScheme.primary
                    ),
                  )
                ],
              ),
              textAlign: .center,
            )
          : GestureDetector(
            onTap: (){
              widget._onResend();
              _restart();
            },
            child: Text(
              context.l10n.resendCode,
              style: TextStyles.font14Weight700.copyWith(
                color: Theme.of(context).colorScheme.primary
              )
            ),
          )
      )
    ],
  );

  String get _formattedRemaining{
    final Duration remaining = Duration(seconds: _remainingSecondsController.value);
    return "${remaining.inMinutes.toString().padLeft(2, "0")}"
      ":${(remaining.inSeconds % 60).toString().padLeft(2, "0")}";
  }

  void _restart(){
    _remainingSecondsController.value = _timeToResend.inSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer){
         _remainingSecondsController.value--;
        if(_remainingSecondsController.value <= 0) timer.cancel();
      }
    );
  }
}
