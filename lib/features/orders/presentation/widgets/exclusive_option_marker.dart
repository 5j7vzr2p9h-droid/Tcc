import 'package:flutter/material.dart';

/// Marks a conditional option that can't be combined with the rest of its group.
final class ExclusiveOptionMarker extends StatelessWidget {
  const new({super.key});

  @override
  Container build(BuildContext context)
  => Container(
    width: 8.0,
    height: 8.0,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.error,
      shape: .circle
    ),
  );
}
