import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/default_circular_indicator.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../../../core/widgets/icon_label.dart';
import '../../../../di.dart';
import '../../../../splash_page.dart';
import '../../domain/entities/legal_list_entity.dart';
import '../viewmodels/terms_viewmodel/terms_cubit.dart';
import '../viewmodels/terms_viewmodel/terms_state.dart';
import '../widgets/terms_agreement_bar.dart';
import '../widgets/terms_section_tile.dart';

final class const TermsAndConditionsPage({super.key}) extends StatelessWidget {
  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(context.l10n.termsAndConditions, style: TextStyles.font18Weight700),
    ),
    body: BlocProvider(
      create: (BuildContext _) => getIt<TermsCubit>()..init(),
      child: BlocBuilder<TermsCubit, TermsState>(
        builder: (BuildContext context, TermsState state)
        => switch(state){
          TermsInitialState() => const SizedBox.shrink(),
          TermsLoadingState() => const Center(child: DefaultCircularIndicator()),
          TermsGetFailureState(:final Failure failure) => Center(
            child: FailurePlaceHolder(
              failure: failure,
              onRetry: context.read<TermsCubit>().init,
            ),
          ),
          TermsGetSuccessState(:final LegalListEntity terms) => ListView(
            padding: const .all(pageContentPadding),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              IconLabel(
                icon: Icons.access_time,
                label: context.l10n.lastUpdated(
                  DateFormat.yMMMd(context.l10n.localeName).format(terms.lastUpdated)
                )
              ),
              const SizedBox(height: defaultItemsSeparator),
              Text(
                context.l10n.termsIntro,
                style: TextStyles.font14Weight400.copyWith(color: Colors.grey)
              ),
              const SizedBox(height: 24.0),
              Material(
                clipBehavior: .antiAlias,
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const .all(.circular(16.0)),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: terms.legalSections.length,
                  separatorBuilder: (BuildContext context, int _) => Divider(
                    height: 0.0,
                    indent: 16.0,
                    endIndent: 16.0,
                    color: Theme.of(context).colorScheme.outline
                  ),
                  itemBuilder: (BuildContext context, int i) => TermsSectionTile(
                    number: i + 1,
                    section: terms.legalSections[i],
                  ),
                ),
              )
            ],
          ),
        }
      ),
    ),
    bottomNavigationBar: TermsAgreementBar(
      onAgreePressed: () => Navigator.pop(context),
    ),
  );
}
