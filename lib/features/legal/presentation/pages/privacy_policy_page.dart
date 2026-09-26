import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/default_circular_indicator.dart';
import '../../../../core/widgets/icon_label.dart';
import '../../../../di.dart';
import '../../../../test_page.dart';
import '../../domain/entities/legal_list_entity.dart';
import '../viewmodels/privacy_policy_viewmodel/privacy_policy_cubit.dart';
import '../viewmodels/privacy_policy_viewmodel/privacy_policy_state.dart';
import '../widgets/privacy_hero_card.dart';
import '../widgets/privacy_section_tile.dart';

final class PrivacyPolicyPage extends StatelessWidget {
  const new({super.key});

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0.0,
      title: Text(context.l10n.privacyPolicy, style: TextStyles.font18Weight700),
    ),
    body: BlocProvider(
      create: (BuildContext context) => getIt<PrivacyPolicyCubit>()..init(),
      child: BlocBuilder<PrivacyPolicyCubit, PrivacyPolicyState>(
        builder: (BuildContext context, PrivacyPolicyState state)
        => switch(state){
          PrivacyPolicyInitialState() => const SizedBox.shrink(),
          PrivacyPolicyLoadingState() => const Center(child: DefaultCircularIndicator()),
          PrivacyPolicyGetFailureState(:final Failure failure) => Center(
            child: FailurePlaceHolder(
              failure: failure,
              onRetry: context.read<PrivacyPolicyCubit>().init,
            ),
          ),
          PrivacyPolicyGetSuccessState(:final LegalListEntity privacyPolicy) => ListView(
            padding: const .all(pageContentPadding),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              const PrivacyHeroCard(),
              const SizedBox(height: 24.0),
              Text(
                context.l10n.privacyIntro,
                style: TextStyles.font14Weight700.copyWith(color: Colors.grey)
              ),
              const SizedBox(height: 24.0),
              Material(
                clipBehavior: .antiAlias,
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const .all(.circular(16.0)),
                child: ListView.separated(
                  padding: .zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: privacyPolicy.legalSections.length,
                  separatorBuilder: (BuildContext context, int _) => Divider(
                    height: 0.0,
                    indent: 16.0,
                    endIndent: 16.0,
                    color: Theme.of(context).colorScheme.outline
                  ),
                  itemBuilder: (BuildContext context, int i) => PrivacySectionTile(
                    number: i + 1,
                    section: privacyPolicy.legalSections[i],
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              IconLabel(
                icon: Icons.calendar_month_outlined,
                label: context.l10n.lastUpdated(
                  DateFormat.yMMMd(context.l10n.localeName).format(privacyPolicy.lastUpdated)
                )
              )
            ],
          ),
        } 
      ),
    ),
  );
}
