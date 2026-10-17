import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/icon_label.dart';

/// Shows the number to send money to and asks for the sender's wallet number, then calls [_onConfirm].
final class VodafoneCashDialog extends StatefulWidget {
  final VoidCallback _onConfirm;

  const new({super.key, required this._onConfirm});

  @override
  State<VodafoneCashDialog> createState() => _VodafoneCashDialogState();
}

class _VodafoneCashDialogState extends State<VodafoneCashDialog> {
  static const String _vfCash = "01200000000";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _onConfirmPressed(){
    if(_formKey.currentState!.validate()){
      Navigator.pop(context);
      widget._onConfirm();
    }
  }

  @override
  AlertDialog build(BuildContext context)
  => AlertDialog(
    content: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        spacing: 8.0,
        children: <Widget>[
          IconLabel(
            icon: Icons.info_outline,
            label: context.l10n.sendMoneyToNumber,
            color: Theme.of(context).colorScheme.primary,
          ),
          TextField(
            readOnly: true,
            textAlign: .center,
            decoration: InputDecoration(
              filled: true,
              hintText: _vfCash,
              fillColor: Colors.grey.shade300,
              prefixIcon: IconButton(
                onPressed: () => Clipboard.setData(const ClipboardData(text: _vfCash)),
                icon: const Icon(Icons.copy)
              )
            ),
          ),
          TextFormField(
            autovalidateMode: .onUserInteraction,
            validator: Validators.getPhoneNumberValidator(context),
            style: TextStyles.font12Weight700,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              hintText: context.l10n.enterWalletNumber,
            ),
          ),
          ElevatedButton(
            onPressed: _onConfirmPressed,
            child: Text(context.l10n.confirmPayment)
          )
        ],
      ),
    )
  );
}
