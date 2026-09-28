import 'package:flutter/material.dart';

import 'text_styles.dart';

abstract final class AppDialog {
  static void showLoadingDialog(
    BuildContext context,
    {String? message}
  ) => showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => PopScope<void>(
      canPop: false,
      child: AlertDialog(
        contentPadding: const .symmetric(
          vertical: 64.0
        ),
        content: Column(
          mainAxisSize: .min,
          children: <Widget>[
            const CircularProgressIndicator(),
            if(message != null)
              Text(
                message,
                style: TextStyles.font20Weight700,
              )
          ],
        )
      ),
    )
  );
}