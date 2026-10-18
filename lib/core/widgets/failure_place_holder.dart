
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/theming/app_colors.dart';
import '../errors/failures.dart';
import '../extensions/context_l10n.dart';
import '../extensions/failure_message.dart';
import '../utils/assets_manager.dart';
import '../utils/text_styles.dart';

final class const FailurePlaceHolder({
  super.key,
  required final Failure _failure,
  required final VoidCallback _onRetry
}) extends StatelessWidget {

  @override
  Column build(BuildContext context)
  => Column(
    mainAxisSize: .min,
    children: <Widget>[
      CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(30),
        radius: 80.0,
        child: SvgPicture.asset(
            switch(_failure){
              ServerFailure() || UnknownFailure() => AssetsManager.serverOff,
              OfflineFailure() => AssetsManager.noWifi,
              LocationDisabledFailure() ||LocationTimeOutFailure() ||
              LocationUnknownFailure() || PermissionAccessDeniedFailure() => AssetsManager.unavailableLocation,
            },
            width: 100.0,
            colorFilter: .mode(
              Theme.of(context).colorScheme.primary,
              .srcATop
            ),
          ),
      ),
      const SizedBox(height: 24.0),
      if(_failure is OfflineFailure)
        ...[
          Text(
            context.l10n.noInternetTitle,
            style: TextStyles.font18Weight700,
            textAlign: .center,
          ),
          const SizedBox(height: 4.0),
        ],
      Text(
        _failure.mapFailureToMessage(context),
        style: TextStyle(
          color: AppColors.of(context).placeHolderForeground
        ),
        textAlign: .center,
      ),
      TextButton.icon(
        onPressed: _onRetry,
        iconAlignment: .end,
        icon: const Icon(Icons.refresh),
        label: Text(context.l10n.retry),
      )
    ],
  );
}