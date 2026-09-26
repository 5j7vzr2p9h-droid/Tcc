import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/handled_network_image.dart';
import '../../../../core/widgets/icon_label.dart';
import '../../domain/entities/offer_entity.dart';

final class OfferCard extends StatelessWidget {
  final OfferEntity _offer;
  final VoidCallback _onOrderPressed;

  const new({
    super.key,
    required this._offer,
    required this._onOrderPressed
  });

  @override
  Material build(BuildContext context)
  => Material(
    clipBehavior: .antiAlias,
    color: Theme.of(context).colorScheme.surface,
    borderRadius: const .all(.circular(16.0)),
    child: Column(
      crossAxisAlignment: .stretch,
      children: <Widget>[
        HandledNetworkImage(
          imageUrl: _offer.image,
          height: 140.0,
          width: MediaQuery.widthOf(context),
        ),
        Padding(
          padding: const .all(16.0),
          child: Column(
            crossAxisAlignment: .start,
            spacing: 8.0,
            children: <Widget>[
              Text(
                _offer.title,
                style: TextStyles.font16Weight700
              ),
              Text(
                _offer.description,
                style: TextStyles.font12Weight400.copyWith(color: Colors.grey)
              ),
              IconLabel(
                icon: Icons.calendar_month_outlined,
                label: context.l10n.offerValidUntil(
                  DateFormat.yMMMd(context.l10n.localeName).format(_offer.validUntil)
                )
              ),
              ElevatedButton(
                onPressed: _onOrderPressed,
                child: Text(context.l10n.orderNow)
              )
            ],
          ),
        )
      ],
    ),
  );
}
