import 'package:flutter/material.dart';

import '../../../../core/extensions/count_formatter.dart';
import '../../../../core/utils/text_styles.dart';

final class RateAndReviewsCount extends StatelessWidget {
  final int _ratingsCount;
  final double _rating;

  const new({
    super.key,
    required this._ratingsCount,
    required this._rating
  });

  @override
  Row build(BuildContext context)
  => Row(
    spacing: 2.0,
    children: [
      Text(
        "(${_ratingsCount.formatCount})",
        style: TextStyles.font12Weight400.copyWith(
          color: Colors.grey
        )
      ),
      Text(
        _rating.toStringAsFixed(1),
        style: TextStyles.font12Weight400
      ),
      Icon(
        Icons.star,
        size: 16.0,
        color: Theme.of(context).colorScheme.primary
      )
    ],
  );
}