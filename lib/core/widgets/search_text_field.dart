import 'package:flutter/material.dart';

import '../utils/app_icons.dart';

final class SearchTextField extends StatelessWidget {
  final String _hintText;
  final TextEditingController _controller;
  final InputBorder? _inputBorder;
  final Widget _suffixIcon;
  final ValueChanged<String>? _onChanged;

  const new({
    super.key,
    required this._controller,
    required this._hintText,
    required this._suffixIcon,
    this._inputBorder,
    this._onChanged
  });

  @override
  PhysicalModel build(BuildContext context)
  => PhysicalModel(
    color: Colors.transparent,
    elevation: 12.0,
    child: TextField(
      onChanged: _onChanged,
      controller: _controller,
      decoration: InputDecoration(
        isDense: true,
        prefixIconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        hintText: _hintText,
        hintStyle: const TextStyle(
          color: Colors.grey
        ),
        filled: true,
        prefixIcon: Icon(AppIcons.search, color: Theme.of(context).colorScheme.primary),
        suffixIcon: _suffixIcon,
        enabledBorder: _inputBorder?? const ShapedInputBorder(
          shape: StadiumBorder(),
          borderSide: .none,
        ),
        focusedBorder: (_inputBorder?? const ShapedInputBorder(
            shape: StadiumBorder(),
            borderSide: .none,
          )).copyWith(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            strokeAlign: BorderSide.strokeAlignOutside,
            width: 2.0
          )
        )
      ),
    ),
  );
}