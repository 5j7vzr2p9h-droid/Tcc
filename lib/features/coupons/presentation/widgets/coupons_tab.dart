import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../core/widgets/empty_data_placeholder.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../../../di.dart';
import '../../domain/entities/coupon_entity.dart';
import '../../domain/entities/coupon_quote_entity.dart';
import '../viewmodels/apply_coupon_viewmodel/apply_coupon_cubit.dart';
import '../viewmodels/apply_coupon_viewmodel/apply_coupon_state.dart';
import '../viewmodels/coupons_viewmodel/coupons_cubit.dart';
import '../viewmodels/coupons_viewmodel/coupons_state.dart';
import 'coupon_code_field.dart';
import 'coupons_list.dart';

final class CouponsTab extends StatefulWidget {
  const new({super.key});

  @override
  State<CouponsTab> createState() => _CouponsTabState();
}

final class _CouponsTabState extends State<CouponsTab> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _onApplyCouponStateChanged(BuildContext context, ApplyCouponState state){
    switch(state){
      case ApplyCouponSuccessState(:final CouponQuoteEntity quote):
        SnackBarMessage.showSuccessMessage(
          context,
          context.l10n.couponAppliedMessage(quote.discount)
        );
      case ApplyCouponEmptyCartState():
        SnackBarMessage.showErrorMessage(context, context.l10n.couponEmptyCartMessage);
      case ApplyCouponFailureState(:final Failure failure):
        SnackBarMessage.showErrorMessage(context, failure.mapFailureToMessage(context));
      case ApplyCouponIdleState() || ApplyCouponLoadingState():
        break;
    }
  }

  @override
  MultiBlocProvider build(BuildContext context)
  => MultiBlocProvider(
    providers: <BlocProvider>[
      BlocProvider<CouponsCubit>(
        create: (BuildContext _) => getIt<CouponsCubit>()..init()
      ),
      BlocProvider<ApplyCouponCubit>(
        create: (BuildContext _) => getIt<ApplyCouponCubit>()
      )
    ],
    child: CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const .all(pageContentPadding),
            child: BlocConsumer<ApplyCouponCubit, ApplyCouponState>(
              listener: _onApplyCouponStateChanged,
              builder: (BuildContext context, ApplyCouponState state)
              => CouponCodeField(
                controller: _codeController,
                isLoading: state is ApplyCouponLoadingState,
                onApplyPressed: () => context.read<ApplyCouponCubit>().apply(_codeController.text),
              ),
            ),
          ),
        ),
        BlocBuilder<CouponsCubit, CouponsState>(
          builder: (BuildContext context, CouponsState state)
          => switch(state){
            CouponsInitialState() => const SliverToBoxAdapter(),
            CouponsLoadingState() => const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            CouponsGetFailureState(:final Failure failure) => SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: FailurePlaceHolder(
                  failure: failure,
                  onRetry: context.read<CouponsCubit>().init,
                ),
              ),
            ),
            CouponsGetSuccessState(
              :final List<CouponEntity> activeCoupons,
              :final List<CouponEntity> expiredCoupons
            ) => activeCoupons.isEmpty && expiredCoupons.isEmpty
              ? SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: EmptyDataPlaceholder(
                    iconData: Icons.discount_outlined,
                    title: context.l10n.noCouponsTitle,
                    description: context.l10n.noCouponsMessage,
                  ),
                ),
              )
              : CouponsList(
                activeCoupons: activeCoupons,
                expiredCoupons: expiredCoupons
              )
          }
        )
      ],
    ),
  );
}
