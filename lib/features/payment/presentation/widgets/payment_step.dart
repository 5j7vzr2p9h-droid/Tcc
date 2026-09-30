import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/empty_data_placeholder.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../domain/entities/payment_method_entity.dart';
import '../viewmodels/payment_methods_viewmodel/payment_methods_cubit.dart';
import '../viewmodels/payment_methods_viewmodel/payment_methods_state.dart';
import 'payment_methods_field.dart';

final class PaymentStep extends StatefulWidget {
  final ValueNotifier<PaymentMethodEntity?> _paymentMethodController;

  const new({
    super.key,
    required this._paymentMethodController
  });

  @override
  State<PaymentStep> createState() => _PaymentStepState();
}

class _PaymentStepState extends State<PaymentStep> {

  @override
  SliverToBoxAdapter build(BuildContext context)
  => SliverToBoxAdapter(
    child: Padding(
      padding: const .all(pageContentPadding),
      child: Column(
        spacing: 28.0,
        children: [
          Column(
            crossAxisAlignment: .start,
            spacing: 12.0,
            children: <Widget>[
              Text(context.l10n.choosePaymentMethod, style: TextStyles.font18Weight700),
              BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
                builder: (BuildContext context, PaymentMethodsState state)
                => switch(state){
                  PaymentMethodsInitialState() => const SizedBox.shrink(),
                  PaymentMethodsLoadingState() => const Padding(
                    padding: .symmetric(vertical: 24.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  PaymentMethodsGetFailureState(:final Failure failure) => Center(
                    child: FailurePlaceHolder(
                      failure: failure,
                      onRetry: context.read<PaymentMethodsCubit>().init,
                    ),
                  ),
                  PaymentMethodsGetSuccessState(:final List<PaymentMethodEntity> methods, :final double balance) => methods.isEmpty
                    ? Center(
                      child: EmptyDataPlaceholder(
                        iconData: Icons.payments_outlined,
                        title: context.l10n.noPaymentMethods,
                      ),
                    )
                    : PaymentMethodsField(
                      controller: widget._paymentMethodController,
                      methods: methods,
                      walletBalance: balance,
                    )
                }
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
