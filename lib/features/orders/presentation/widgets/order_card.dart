import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/handled_network_image.dart';
import '../../domain/entities/order_entity.dart';
import 'order_action_button.dart';
import 'order_status_chip.dart';

final class OrderCard extends StatelessWidget {
  final OrderEntity _order;
  final VoidCallback _onDetailsPressed, _onActionPressed;

  const new({
    super.key,
    required this._order,
    required this._onDetailsPressed,
    required this._onActionPressed
  });

  @override
  Container build(BuildContext context)
  => Container(
    padding: const .all(16.0),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: .circular(16.0),
      border: .all(
        color: Theme.of(context).colorScheme.outline
      )
    ),
    child: Column(
      crossAxisAlignment: .start,
      spacing: 12.0,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 4.0,
                children: <Widget>[
                  Text(
                    "#${_order.id}",
                    style: TextStyles.font16Weight700
                  ),
                  Text(
                    DateFormat.jm(context.l10n.localeName).add_yMMMd().format(_order.date),
                    style: TextStyles.font12Weight400.copyWith(
                      color: Colors.grey
                    )
                  )
                ],
              ),
            ),
            OrderStatusChip(
              status: _order.status,
            )
          ],
        ),
        Row(
          spacing: 12.0,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 4.0,
                children: <Widget>[
                  Row(
                    spacing: 4.0,
                    children: <Widget>[
                      const Icon(
                        Icons.location_on_outlined,
                        size: 16.0,
                        color: Colors.grey
                      ),
                      Text(
                        context.l10n.deliveryTo,
                        style: TextStyles.font12Weight400.copyWith(
                          color: Colors.grey
                        )
                      )
                    ],
                  ),
                  Text(
                    _order.deliveyAddress,
                    style: TextStyles.font14Weight700
                  ),
                  InkWell(
                    onTap: _onDetailsPressed,
                    child: Text(
                      context.l10n.showDetails,
                      style: TextStyles.font12Weight700.copyWith(
                        color: Theme.of(context).colorScheme.error
                      )
                    ),
                  )
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const .all(.circular(12.0)),
              child: HandledNetworkImage(
                imageUrl: _order.image,
                width: 80.0,
                height: 80.0,
              ),
            )
          ],
        ),
        Divider(
          height: 0.0,
          color: Theme.of(context).colorScheme.outline
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 2.0,
                children: <Widget>[
                  Text(
                    context.l10n.total,
                    style: TextStyles.font12Weight400.copyWith(
                      color: Colors.grey
                    )
                  ),
                  Text(
                    "${_order.total.toStringAsFixed(0)} ${context.l10n.pound}",
                    style: TextStyles.font16Weight700.copyWith(
                      color: Theme.of(context).colorScheme.error
                    )
                  )
                ],
              ),
            ),
            OrderActionButton(
              isTracking: _order.status == .held,
              onPressed: _onActionPressed,
            )
          ],
        )
      ],
    ),
  );
}
