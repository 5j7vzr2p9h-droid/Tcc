import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import 'order_field_title.dart';

final class NotesField extends StatelessWidget {
  final TextEditingController _textController;

  const new(this._textController, {super.key});

  @override
  Column build(BuildContext context)
  => Column(
    spacing: 4.0,
    children: <Widget>[
      OrderFieldTitle(title: context.l10n.orderNotes),
      TextField(
        controller: _textController,
        keyboardType: .multiline,
        style: TextStyles.font14Weight400,
        maxLength: 250,
        maxLines: 2,
        decoration: InputDecoration(
          hintText: context.l10n.orderNotesHint,
          border: OutlineInputBorder(
            borderRadius: .circular(8.0),
          ),
          counterStyle: const TextStyle(
            color: Colors.grey
          )
        ),
      ),
      Text(
        context.l10n.orderNotesDescription,
        style: TextStyles.font12Weight400.copyWith(
          color: Colors.grey
        ),
        textAlign: .center,
      )
    ],
  );
}