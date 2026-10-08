import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

final class AuthTextField extends StatelessWidget {
  final TextEditingController _textController;
  final String _label;
  final String? _hint;
  final IconData _icon;
  final TextInputType _keyboardType;
  final FormFieldValidator<String>? _validator;
  final Widget? _suffix;
  final bool _enabled, _readOnly;
  final AutovalidateMode? _autovalidateMode;

  const new({
    super.key,
    required this._textController,
    required this._label,
    this._hint,
    required this._icon,
    this._keyboardType = TextInputType.text,
    this._validator,
    this._suffix,
    this._enabled = true,
    this._readOnly = false,
    this._autovalidateMode
  });

  @override
  TextFormField build(BuildContext context)
  => TextFormField(
    enabled: _enabled,
    readOnly: _readOnly,
    controller: _textController,
    keyboardType: _keyboardType,
    style: TextStyles.font14Weight400,
    validator: _validator,
    autovalidateMode: _autovalidateMode,
    decoration: InputDecoration(
      labelText: _label,
      hintText: _hint,
      prefixIcon: Icon(_icon),
      suffixIcon: _suffix
    ),
  );
}
