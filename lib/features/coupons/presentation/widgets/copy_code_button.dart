import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class CopyCodeButton extends StatelessWidget {
  final String _code;

  const new({
    super.key,
    required this._code
  });

  @override
  TextButton build(BuildContext context)
  => TextButton.icon(
    onPressed: () async{
      await Clipboard.setData(ClipboardData(text: _code));
      if(context.mounted) ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: .floating,
            margin: const .all(16.0),
            content: Text(context.l10n.codeCopied)
          )
        );
    },
    style: TextButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(15),
      foregroundColor: Theme.of(context).colorScheme.primary,
      textStyle: TextStyles.font14Weight700,
      minimumSize: const .fromHeight(44.0),
      shape: const RoundedRectangleBorder()
    ),
    icon: const Icon(Icons.copy, size: 18.0),
    label: Text(context.l10n.copyCode)
  );
}
