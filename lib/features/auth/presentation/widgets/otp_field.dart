import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/text_styles.dart';

final class OtpField extends StatefulWidget {
  static const int _length = 6;

  final TextEditingController _textController;
  final VoidCallback _onCompleted;

  const new({
    super.key,
    required this._textController,
    required this._onCompleted
  });

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  static const double _boxesSeparator = 12.0;

  late final List<TextEditingController> _digitControllers;
  late final List<FocusNode> _digitNodes, _keyboardNodes;

  @override
  void initState(){
    super.initState();
    _digitControllers = List<TextEditingController>.generate(
      OtpField._length,
      (int _) => TextEditingController(),
      growable: false
    );
    _digitNodes = List<FocusNode>.generate(
      OtpField._length,
      (int _) => FocusNode(),
      growable: false
    )..first.requestFocus();
    _keyboardNodes = List<FocusNode>.generate(
      OtpField._length,
      (int _) => FocusNode(skipTraversal: true, canRequestFocus: false),
      growable: false
    );
  }

  @override
  void dispose(){
    for(final TextEditingController digitController in _digitControllers)
      digitController.dispose();
    for(final FocusNode digitNode in _digitNodes)
      digitNode.dispose();
    for(final FocusNode keyboardNode in _keyboardNodes)
      keyboardNode.dispose();
    super.dispose();
  }

  @override
  FormField<String> build(BuildContext context)
  => FormField<String>(
    autovalidateMode: .onUserInteraction,
    validator: (String? _){
      if(widget._textController.text.isEmpty)
        return "رمز التحقق مطلوب";
      else if(widget._textController.text.length < OtpField._length)
        return "رمز التحقق غير مكتمل";
      return null;
    },
    builder: (FormFieldState<String> field) => Column(
      spacing: 8.0,
      children: <Widget>[
        Row(
          spacing: _boxesSeparator,
          textDirection: .ltr,
          children: List<Widget>.generate(
            OtpField._length,
            (int index) => Expanded(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: KeyboardListener(
                  focusNode: _keyboardNodes[index],
                  onKeyEvent: (KeyEvent event){
                    if(event is KeyDownEvent
                      && event.logicalKey == LogicalKeyboardKey.backspace
                      && _digitControllers[index].text.isEmpty)
                      _clearPrevious(index, field);
                  },
                  child: TextField(
                    controller: _digitControllers[index],
                    focusNode: _digitNodes[index],
                    keyboardType: .number,
                    textAlign: .center,
                    textAlignVertical: .center,
                    expands: true,
                    maxLength: 1,
                    maxLines: null,
                    minLines: null,
                    style: TextStyles.font20Weight700,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    onChanged: (String value) {
                      _publish(field);
                      if(value.isNotEmpty)
                        _moveTo(index + 1);
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: .zero,
                      enabledBorder: field.hasError?
                        _border(Theme.of(context).colorScheme.error): null,
                      focusedBorder: _border(Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
              ),
            ),
            growable: false
          ),
        ),
        if(field.hasError)
          Text(
            field.errorText!,
            style: TextStyles.font12Weight700.copyWith(
              color: Theme.of(context).colorScheme.error
            )
          )
      ],
    ),
  );


  OutlineInputBorder _border(Color color)
  => OutlineInputBorder(
    borderRadius: .circular(8.0),
    borderSide: BorderSide(color: color, width: 1.5)
  );

  void _publish(FormFieldState<String> field){
    final String code = _digitControllers
      .map((TextEditingController digitController) => digitController.text)
      .join();
    widget._textController.text = code;
    if(code.length < OtpField._length) return;
    widget._onCompleted();
  }

  void _clearPrevious(int index, FormFieldState<String> field){
    if(index == 0) return;
    _digitControllers[index - 1].clear();
    _publish(field);
    _moveTo(index - 1);
  }

  void _moveTo(int index){
    if(index < 0) return;
    else if(index >= OtpField._length)
      _digitNodes[OtpField._length - 1].unfocus();
    else
      _digitNodes[index].requestFocus();
  }
}
