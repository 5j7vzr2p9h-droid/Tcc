import 'package:flutter/material.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';

final class PrimaryAddressSwitch extends StatelessWidget {
  final ValueNotifier<bool> _controller;

  const new({
    super.key,
    required this._controller
  });

  @override
  Material build(BuildContext context)
  => Material(
    color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12.0),
        side: BorderSide(color: Theme.of(context).colorScheme.outline)
      ),
    child: InkWell(
      onTap: () => _controller.value = !_controller.value,
      child: Padding(
        padding: const .symmetric(
          horizontal: 16.0,
          vertical: 8.0
        ),
        child: Row(
          spacing: 12.0,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 2.0,
                children: <Widget>[
                  Text(
                    context.l10n.setAsDefaultAddress,
                    style: TextStyles.font14Weight700
                  ),
                  Text(
                    context.l10n.defaultAddressDescription,
                    style: TextStyles.font12Weight400.copyWith(
                      color: Colors.grey
                    )
                  )
                ],
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _controller,
              builder: (BuildContext context, bool isPrimary, Widget? child)
              => Switch(
                value: isPrimary,
                onChanged: (bool value) => _controller.value = value,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
