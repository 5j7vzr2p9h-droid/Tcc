import 'package:flutter/material.dart';

import '../../config/routing/routes.dart';
import '../../features/cart/presentation/widgets/cart_summary_bar.dart';
import 'text_styles.dart';

abstract final class SnackBarMessage {
  static const Duration _duration = Duration(seconds: 3);

  static void showErrorMessage(BuildContext context, String message)
  => ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(
    SnackBar(
      duration: _duration,
      behavior: .floating,
      margin: const .all(16.0),
      padding: const .all(12.0),
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: const .all(.circular(12.0)),
        side: BorderSide(
          color: Theme.of(context).colorScheme.error.withAlpha(100)
        )
      ),
      content: Row(
        spacing: 8.0,
        children: <Widget>[
          Icon(
            Icons.error,
            size: 18.0,
            color: Theme.of(context).colorScheme.error
          ),
          Expanded(
            child: Text(
              message,
              style: TextStyles.font12Weight700.copyWith(
                color: Theme.of(context).colorScheme.error
              ),
            ),
          )
        ],
      ),
    )
  );

  static void showSuccessMessage(BuildContext context, String message)
  => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: _duration,
      behavior: .floating,
      margin: const .all(16.0),
      padding: const .all(12.0),
      backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(20),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: const .all(.circular(12.0)),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary.withAlpha(100)
        )
      ),
      content: Row(
        spacing: 8.0,
        children: <Widget>[
          Icon(
            Icons.send,
            size: 18.0,
            color: Theme.of(context).colorScheme.primary
          ),
          Expanded(
            child: Text(
              message,
              style: TextStyles.font12Weight700.copyWith(
                color: Theme.of(context).colorScheme.primary
              ),
            ),
          )
        ],
      ),
    )
  );
  
  static void showProductAddedMessage(BuildContext context)
  => ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(SnackBar(
    margin: const .only(
      bottom: 64.0
    ),
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    behavior: .floating,
    content: CartSummaryBar(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Navigator.pushNamed(context, Routes.payment);
      },
    )
  ));
}
