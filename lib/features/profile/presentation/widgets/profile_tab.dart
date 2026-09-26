import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/constants/numerical_values.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/default_circular_indicator.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../../../di.dart';
import '../../../../splash_page.dart';
import '../viewmodel/profile_cubit.dart';
import '../viewmodel/profile_state.dart';
import 'profile_header.dart';
import 'profile_menu_section.dart';
import 'profile_menu_tile.dart';

final class ProfileTab extends StatelessWidget {
  final VoidCallback _onOrdersClicked;

  const new(this._onOrdersClicked, {super.key});

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(title: Text(context.l10n.myAccount)),
    body: BlocProvider<ProfileCubit>(
      create: (BuildContext _) => getIt<ProfileCubit>()..init(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (BuildContext context, ProfileState state){
          if(state is LogoutFailureState)
            SnackBarMessage.showErrorMessage(context, state.failure.mapFailureToMessage(context));
        },
        builder: (BuildContext context, ProfileState state)
        => switch(state){
          ProfileInitialState() => const SizedBox.shrink(),
          ProfileLoadingState() => const Center(
            child: DefaultCircularIndicator(),
          ),
          ProfileGetFailureState(:final Failure failure) => Center(
            child: FailurePlaceHolder(
              failure: failure,
              onRetry: (){


              },
            ),
          ),
          ProfileGetSuccessState() || LogoutFailureState() => ListView(
            padding: const .only(
              top: pageContentPadding,
              left: pageContentPadding,
              right: pageContentPadding,
              bottom: 96.0,
            ),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              ProfileHeader(
                name: "محمد أحمد",
                phoneNumber: "010 1234 5678",
                onEditPressed: (){},
              ),
              const SizedBox(height: 24.0),
              ProfileMenuSection(
                tiles: <ProfileMenuTile>[
                  ProfileMenuTile(
                    icon: Icons.location_on_outlined,
                    title: context.l10n.addresses,
                    onTap: () => Navigator.pushNamed(context, Routes.savedAddresses),
                  ),
                  ProfileMenuTile(
                    icon: Icons.receipt_long_outlined,
                    title: context.l10n.orders,
                    onTap: _onOrdersClicked,
                  ),
                  ProfileMenuTile(
                    icon: Icons.favorite_outline,
                    title: context.l10n.favorites,
                    onTap: () => Navigator.pushNamed(context, Routes.favorites),
                  ),
                  ProfileMenuTile(
                    icon: Icons.credit_card,
                    title: context.l10n.paymentMethods,
                    onTap: () => Navigator.pushNamed(context, Routes.paymentMethods),
                  ),
                  ProfileMenuTile(
                    icon: Icons.discount_outlined,
                    title: context.l10n.couponsOffers,
                    onTap: () => Navigator.pushNamed(context, Routes.couponsAndOffers),
                  ),
                  ProfileMenuTile(
                    icon: Icons.headset_mic_outlined,
                    title: context.l10n.support,
                    onTap: () => Navigator.pushNamed(context, Routes.support),
                  )
                ],
              ),
              const SizedBox(height: defaultItemsSeparator),
              ProfileMenuSection(
                tiles: <ProfileMenuTile>[
                  ProfileMenuTile(
                    icon: Icons.share_outlined,
                    title: context.l10n.shareApp,
                    color: Theme.of(context).colorScheme.primary,
                    onTap: (){},
                  ),
                  ProfileMenuTile(
                    icon: Icons.shield_outlined,
                    title: context.l10n.privacyPolicy,
                    onTap: () => Navigator.pushNamed(context, Routes.privacyPolicy),
                  ),
                  ProfileMenuTile(
                    icon: Icons.description_outlined,
                    title: context.l10n.termsAndConditions,
                    onTap: () => Navigator.pushNamed(context, Routes.termsAndConditions),
                  ),
                  ProfileMenuTile(
                    icon: Icons.settings_outlined,
                    title: context.l10n.settings,
                    onTap: () => Navigator.pushNamed(context, Routes.settings),
                  ),
                  ProfileMenuTile(
                    icon: Icons.logout,
                    title: context.l10n.logout,
                    color: Theme.of(context).colorScheme.error,
                    onTap: () => context.read<ProfileCubit>().logout(),
                  )
                ],
              ),
              const SizedBox(height: defaultItemsSeparator),
              Text(
                "${context.l10n.version} 1.0.0",
                textAlign: .center,
                style: TextStyles.font12Weight400.copyWith(
                  color: Colors.grey
                ),
              ),
            ],
          ),
        }
      ),
    ),
  );
}
