import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';
import '../../../../core/utils/validators.dart';

final class AddressTextField extends StatelessWidget {
  final TextEditingController _textController;
  final String _label, _hint;
  final IconData _icon;
  final VoidCallback? _onTap;
  final int _linesNumber;

  const new({
    super.key,
    required this._textController,
    required this._label,
    required this._hint,
    required this._icon,
    this._onTap,
    this._linesNumber = 1
  });

  @override
  Column build(BuildContext context)
  => Column(
    crossAxisAlignment: .start,
    spacing: 8.0,
    children: <Widget>[
      Text(_label, style: TextStyles.font14Weight700),
      TextFormField(
        controller: _textController,
        validator: Validators.getDetailedAddressValidator(context),
        maxLines: _linesNumber,
        minLines: _linesNumber,
        style: TextStyles.font14Weight400,
        readOnly: _onTap != null,
        onTap: _onTap,
        decoration: InputDecoration(
          hintText: _hint,
          contentPadding: const .symmetric(
            horizontal: 12.0,
            vertical: 16.0
          ),
          prefixIcon: Icon(
            _icon,
            color: Theme.of(context).colorScheme.primary
          )
        ),
      )
    ],
  );
}
