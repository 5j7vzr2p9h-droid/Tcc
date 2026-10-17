import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/utils/validators.dart';

/// Asks for the InstaPay username the user will pay from, then calls [_onConfirm].
final class InstaPayDialog extends StatefulWidget {
  final VoidCallback _onConfirm;

  const new({super.key, required this._onConfirm});

  @override
  State<InstaPayDialog> createState() => _InstaPayDialogState();
}

class _InstaPayDialogState extends State<InstaPayDialog> {
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
        mainAxisSize: .min,
        spacing: 8.0,
        children: <Widget>[
          TextFormField(
            autovalidateMode: .onUserInteraction,
            validator: Validators.getInstaPayUsernameValidator(context),
            style: TextStyles.font12Weight700,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade300,
              hintText: context.l10n.enterInstaPayUsername,
              border: const OutlineInputBorder(
                borderRadius: .all(.circular(12.0)),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: .all(.circular(16.0)),
                borderSide: .none
              ),
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
