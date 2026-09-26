import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

final class AuthTextField extends StatelessWidget {
  final TextEditingController _textController;
  final String _label, _hint;
  final IconData _icon;
  final TextInputType _keyboardType;
  final FormFieldValidator<String>? _validator;
  final Widget? _suffix;
  final bool _enabled;

  const new({
    super.key,
    required this._textController,
    required this._label,
    required this._hint,
    required this._icon,
    this._keyboardType = TextInputType.text,
    this._validator,
    this._suffix,
    this._enabled = true
  });

  @override
  TextFormField build(BuildContext context)
  => TextFormField(
    enabled: _enabled,
    controller: _textController,
    keyboardType: _keyboardType,
    style: TextStyles.font14Weight400,
    validator: _validator,
    decoration: InputDecoration(
      labelText: _label,
      hintText: _hint,
      prefixIcon: Icon(_icon),
      suffixIcon: _suffix
    ),
  );
}
