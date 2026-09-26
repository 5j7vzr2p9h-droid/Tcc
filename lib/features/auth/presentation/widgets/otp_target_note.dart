import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

final class OtpTargetNote extends StatefulWidget {
  final String _phoneNumber;
  final VoidCallback _onChangeNumber;

  const new({
    super.key,
    required this._phoneNumber,
    required this._onChangeNumber
  });

  @override
  State<OtpTargetNote> createState() => _OtpTargetNoteState();
}

class _OtpTargetNoteState extends State<OtpTargetNote> {
  final TapGestureRecognizer _changeNumberRecognizer = TapGestureRecognizer();

  @override
  void dispose(){
    _changeNumberRecognizer.dispose();
    super.dispose();
  }

  @override
  Text build(BuildContext context)
  => Text.rich(
    TextSpan(
      style: TextStyles.font14Weight700.copyWith(
        color: Theme.of(context).colorScheme.primary
      ),
      children: <InlineSpan>[
        TextSpan(text: widget._phoneNumber),
        TextSpan(
          text: " ، ",
          style: TextStyles.font14Weight400.copyWith(color: Colors.grey)
        ),
        TextSpan(
          text: "تغيير الرقم",
          recognizer: _changeNumberRecognizer..onTap = widget._onChangeNumber
        )
      ],
    ),
    textAlign: .center,
    textDirection: .rtl,
  );
}
