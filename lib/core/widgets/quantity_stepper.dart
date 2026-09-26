import 'package:flutter/material.dart';

import '../utils/text_styles.dart';

final class QuantityStepper extends StatelessWidget {
  final ValueNotifier<int> _controller;
  final int _min;
  final int? _max;

  const new({
    super.key,
    required this._controller,
    this._min = 1,
    this._max
  });

  @override
  ValueListenableBuilder<int> build(BuildContext context)
  => ValueListenableBuilder<int>(
    valueListenable: _controller,
    builder: (BuildContext context, int value, Widget? child)
    => Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: .circular(16.0),
        border: .all(
          color: Theme.of(context).colorScheme.outline
        ),
      ),
      child: Row(
        mainAxisSize: .min,
        children: <Widget>[
          IconButton(
            onPressed: value > _min? () => _controller.value--: null,
            style: IconButton.styleFrom(tapTargetSize: .shrinkWrap),
            icon: const Icon(Icons.remove)
          ),
          SizedBox(
            width: 24.0,
            child: Text(
              "$value",
              textAlign: .center,
              style: TextStyles.font14Weight700
            ),
          ),
          IconButton(
            onPressed: _max == null || value < _max? () => _controller.value++: null,
            style: IconButton.styleFrom(tapTargetSize: .shrinkWrap),
            icon: const Icon(Icons.add)
          ),
        ],
      ),
    ),
  );
}
