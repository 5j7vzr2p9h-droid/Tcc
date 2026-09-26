import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

final class OtpResendTimer extends StatefulWidget {
  final Duration _duration;
  final VoidCallback _onResend;

  const new({
    super.key,
    this._duration = const Duration(seconds: 45),
    required this._onResend
  });

  @override
  State<OtpResendTimer> createState() => _OtpResendTimerState();
}

class _OtpResendTimerState extends State<OtpResendTimer> {
  Timer? _timer;
  int _remainingSeconds = 0;

  @override
  void initState(){
    super.initState();
    _restart();
  }

  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }

  @override
  Column build(BuildContext context)
  => Column(
    spacing: 4.0,
    children: <Widget>[
      Text(
        "لم تستلم الرمز؟",
        style: TextStyles.font14Weight400.copyWith(color: Colors.grey)
      ),
      _remainingSeconds > 0?
        _countdown(context):
        _resendAction(context)
    ],
  );

  Text _countdown(BuildContext context)
  => Text.rich(
    TextSpan(
      style: TextStyles.font14Weight400.copyWith(color: Colors.grey),
      children: <InlineSpan>[
        const TextSpan(text: "إعادة إرسال الرمز خلال "),
        TextSpan(
          text: _formattedRemaining,
          style: TextStyles.font14Weight700.copyWith(
            color: Theme.of(context).colorScheme.primary
          )
        )
      ],
    ),
    textAlign: .center,
    textDirection: .rtl,
  );

  GestureDetector _resendAction(BuildContext context)
  => GestureDetector(
    onTap: (){
      setState(_restart);
      widget._onResend();
    },
    child: Text(
      "إعادة إرسال الرمز",
      style: TextStyles.font14Weight700.copyWith(
        color: Theme.of(context).colorScheme.primary
      )
    ),
  );

  String get _formattedRemaining{
    final Duration remaining = Duration(seconds: _remainingSeconds);
    return "${remaining.inMinutes.toString().padLeft(2, "0")}"
      ":${(remaining.inSeconds % 60).toString().padLeft(2, "0")}";
  }

  void _restart(){
    _remainingSeconds = widget._duration.inSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer){
        setState(() => _remainingSeconds--);
        if(_remainingSeconds <= 0) timer.cancel();
      }
    );
  }
}
