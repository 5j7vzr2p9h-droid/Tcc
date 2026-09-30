import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/widgets/empty_data_placeholder.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../../../di.dart';
import '../../domain/entities/order_entity.dart';
import '../viewmodels/previous_orders_viewmodel/previous_orders_cubit.dart';
import '../viewmodels/previous_orders_viewmodel/previous_orders_state.dart';
import 'orders_filter_dropdown_button.dart';
import 'orders_list.dart';

final class PreviousOrdersTab extends StatefulWidget {
  const new({super.key});

  @override
  State<PreviousOrdersTab> createState() => _PreviousOrdersTabState();
}

final class _PreviousOrdersTabState extends State<PreviousOrdersTab> {
  final ValueNotifier<String> _selectedFilter = ValueNotifier<String>(OrdersFilterDropdownButton.filters.first);

  @override
  void dispose() {
    _selectedFilter.dispose();
    super.dispose();
  }

  @override
  Column build(BuildContext context)
  => Column(
    crossAxisAlignment: .start,
    children: <Widget>[
      Padding(
        padding: const .only(
          top: pageContentPadding,
          right: pageContentPadding,
          left: pageContentPadding,
          bottom: 4.0
        ),
        child: OrdersFilterDropdownButton(
          selectedFilter: _selectedFilter,
        ),
      ),
      Expanded(
        child: BlocProvider<PreviousOrdersCubit>(
          create: (BuildContext _) => getIt<PreviousOrdersCubit>()..init(),
          child: BlocBuilder<PreviousOrdersCubit, PreviousOrdersState>(
            builder: (BuildContext context, PreviousOrdersState state)
            => switch(state){
              PreviousOrdersInitialState() => const SizedBox.shrink(),
              PreviousOrdersLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
              PreviousOrdersGetFailureState(:final Failure failure) => Center(
                child: FailurePlaceHolder(
                  failure: failure,
                  onRetry: context.read<PreviousOrdersCubit>().init,
                ),
              ),
              PreviousOrdersGetSuccessState(:final List<OrderEntity> orders) 
              => orders.isEmpty
                ? Center(
                  child: EmptyDataPlaceholder(
                    iconData: AppIcons.no_bag,
                    title: context.l10n.noPreviousOrdersTitle,
                  ),
                )
                : OrdersList(orders)
            }
          ),
        ),
      )
    ],
  );
}