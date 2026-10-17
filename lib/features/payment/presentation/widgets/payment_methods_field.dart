import 'package:flutter/material.dart';

import '../../domain/entities/payment_method_entity.dart';
import 'payment_method_tile.dart';

final class PaymentMethodsField extends StatelessWidget {
  final ValueNotifier<PaymentMethodEntity?> _controller;
  final List<PaymentMethodEntity> _methods;

  const new({
    super.key,
    required this._controller,
    required this._methods
  });

  @override
  ValueListenableBuilder<PaymentMethodEntity?> build(BuildContext context)
  => ValueListenableBuilder<PaymentMethodEntity?>(
    valueListenable: _controller,
    builder: (BuildContext context, PaymentMethodEntity? value, Widget? child)
    => Column(
      spacing: 12.0,
      children: <Widget>[
        for (final PaymentMethodEntity method in _methods)
          PaymentMethodTile(
            title: method.name,
            selected: value?.id == method.id,
            onTap: () => _controller.value = method
          )
      ],
    ),
  );
}
