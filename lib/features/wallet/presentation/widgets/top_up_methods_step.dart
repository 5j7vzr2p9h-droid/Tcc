import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../../core/widgets/empty_data_placeholder.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../../payment/domain/entities/payment_method_entity.dart';
import '../../../payment/presentation/viewmodels/payment_methods_viewmodel/payment_methods_cubit.dart';
import '../../../payment/presentation/viewmodels/payment_methods_viewmodel/payment_methods_state.dart';
import '../../../payment/presentation/widgets/payment_methods_field.dart';

/// The methods the wallet can be topped up with, loaded from the API.
final class const TopUpMethodsStep({
  super.key,
  required final ValueNotifier<PaymentMethodEntity?> _paymentMethodController
}) extends StatelessWidget {

  static bool isTopUpMethod(PaymentMethodEntity method) => method.requiresProof;

  Widget _buildMethods(BuildContext context, List<PaymentMethodEntity> methods)
  => methods.isEmpty
    ? Center(
      child: EmptyDataPlaceholder(
        iconData: Icons.payments_outlined,
        title: context.l10n.noPaymentMethods,
      ),
    )
    : PaymentMethodsField(
      controller: _paymentMethodController,
      methods: methods
    );

  @override
  Padding build(BuildContext context)
  => Padding(
    padding: const .all(pageContentPadding),
    child: Column(
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
            PaymentMethodsGetSuccessState(:final List<PaymentMethodEntity> methods) => _buildMethods(
              context,
              methods.where(isTopUpMethod).toList()
            )
          }
        ),
      ],
    ),
  );
}
