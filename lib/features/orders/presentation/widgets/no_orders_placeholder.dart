import 'package:flutter/material.dart';

import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/text_styles.dart';

final class NoOrdersPlaceholder extends StatelessWidget {
  const new({super.key});

  @override
  Center build(BuildContext context)
  => Center(
    child: Column(
      mainAxisAlignment: .center,
      spacing: 12.0,
      children: <Widget>[
        Icon(
          AppIcons.no_bag,
          size: 140.0,
          color: Theme.of(context).colorScheme.primary,
        ),
        const Text(
          "لا توجد طلبات حديثة",
          style: TextStyles.font20Weight700,
        ),
        Text(
          "عندما تقوم بطلبك، سيظهر هنا.",
          style: TextStyles.font14Weight700.copyWith(
            color: Colors.grey
          ),
        )
      ],
    ),
  );
}