import 'package:flutter/material.dart';

import '../../domain/entities/payment_method_entity.dart';
import 'payment_method_tile.dart';

final class PaymentMethodsField extends StatelessWidget {
  final ValueNotifier<int> _controller;
  final List<PaymentMethodEntity> _methods;

  const new({
    super.key,
    required this._controller,
    required this._methods
  });

  @override
  ValueListenableBuilder<int> build(BuildContext context)
  => ValueListenableBuilder<int>(
    valueListenable: _controller,
    builder: (BuildContext context, int value, Widget? child)
    => Column(
      spacing: 12.0,
      children: <Widget>[
        for (int i = 0; i < _methods.length; i++)
          PaymentMethodTile(
            method: _methods[i],
            selected: value == i,
            balance: i==0? null: 500.0,
            onTap: () => _controller.value = i,
          )
      ],
    ),
  );
}
