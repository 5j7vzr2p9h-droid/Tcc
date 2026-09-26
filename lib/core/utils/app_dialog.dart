import 'package:flutter/material.dart';

import '../widgets/default_circular_indicator.dart';
import 'text_styles.dart';

abstract final class AppDialog {
  static void showLoadingDialog(
    BuildContext context,
    {String? message}
  ) => showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => AlertDialog(
      content: Column(
        mainAxisSize: .min,
        children: <Widget>[
          const DefaultCircularIndicator(),
          if(message != null)
            Text(
              message,
              style: TextStyles.font20Weight700,
            )
        ],
      )
    )
  );
}