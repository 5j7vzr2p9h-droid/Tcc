import 'package:flutter/material.dart';

import '../../../../core/utils/app_icons.dart';
import '../../../../core/utils/text_styles.dart';

final class NoNotificationsPlaceholder extends StatelessWidget {
  final VoidCallback _onOrdersPressed;

  const new({
    super.key,
    required this._onOrdersPressed
  });

  @override
  Column build(BuildContext context)
  => Column(
    spacing: 12.0,
    children: <Widget>[
      const Spacer(),
      Stack(
        alignment: .topRight,
        children: <Widget>[
          Container(
            width: 180.0,
            height: 180.0,
            alignment: .center,
            decoration: BoxDecoration(
              shape: .circle,
              color: Theme.of(context).colorScheme.primary.withAlpha(20)
            ),
            child: Icon(
              AppIcons.notification,
              size: 90.0,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          CircleAvatar(
            radius: 24.0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              "0",
              style: TextStyles.font20Weight900.copyWith(
                color: Theme.of(context).colorScheme.onPrimary
              ),
            ),
          )
        ],
      ),
      const SizedBox(height: 12.0),
      const Text(
        "لا يوجد إشعارات",
        style: TextStyles.font20Weight700,
      ),
      Text(
        "عند وجود أي إشعارات جديدة، ستظهر هنا.",
        style: TextStyles.font14Weight700.copyWith(
          color: Colors.grey
        ),
      ),
      const Spacer(),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _onOrdersPressed,
          child: const Text("عرض الطلبات")
        ),
      )
    ],
  );
}
