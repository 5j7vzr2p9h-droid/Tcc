import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/app_icons.dart';
import '../../../../core/widgets/empty_data_placeholder.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../../../di.dart';
import '../../domain/entities/order_entity.dart';
import '../viewmodels/current_orders_view/current_orders_cubit.dart';
import '../viewmodels/current_orders_view/current_orders_state.dart';
import 'orders_list.dart';

final class const CurrentOrdersTab({super.key}) extends StatelessWidget {

  @override
  BlocProvider<CurrentOrdersCubit> build(BuildContext context)
  => BlocProvider<CurrentOrdersCubit>(
    create: (BuildContext context) => getIt<CurrentOrdersCubit>()..init(),
    child: BlocBuilder<CurrentOrdersCubit, CurrentOrdersState>(
      builder: (BuildContext context, CurrentOrdersState state)
      => switch(state){
        CurrentOrdersInitialState() => const SizedBox.shrink(),
        CurrentOrdersLoadingState() => const Center(
          child: CircularProgressIndicator(),
        ),
        CurrentOrdersGetFailureState(:final Failure failure) => Center(
          child: FailurePlaceHolder(
            failure: failure,
            onRetry: context.read<CurrentOrdersCubit>().init,
          ),
        ),
        CurrentOrdersGetSuccessState(:final List<OrderEntity> orders) 
        => orders.isEmpty
          ? Center(
            child: EmptyDataPlaceholder(
              iconData: AppIcons.no_bag,
              title: context.l10n.noNewOrdersTitle,
              description: context.l10n.noNewOrdersMessage,
            ),
          )
          : OrdersList(orders)
      }
    ),
  );
}
