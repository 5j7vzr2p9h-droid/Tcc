import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routing/routes.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/widgets/failure_place_holder.dart';
import '../../../../di.dart';
import '../viewmodels/request_location_permession_viewmodel/request_location_permession_cubit.dart';
import '../viewmodels/request_location_permession_viewmodel/request_location_permession_state.dart';

final class const RequestLocationPermessionPage({super.key}) extends StatelessWidget {

  @override
  Scaffold build(BuildContext context)
  => Scaffold(
    body: Center(
      child: BlocProvider<RequestLocationPermessionCubit>(
        create: (BuildContext _) => getIt<RequestLocationPermessionCubit>()..requestLocation(),
        child: BlocConsumer<RequestLocationPermessionCubit, RequestLocationPermessionState>(
          listener: (BuildContext context, RequestLocationPermessionState state){
            if(state is RequestLocationPermessionSuccessState)
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.main,
                (Route<dynamic> route) => false
              );
          },
          builder: (BuildContext context, RequestLocationPermessionState state)
          => switch(state){
            RequestLocationPermessionInitialState() || RequestLocationPermessionSuccessState() => const Center(child: CircularProgressIndicator()),
            RequestLocationPermessionFailureState(:final Failure failure) => Center(
              child: FailurePlaceHolder(
                failure: failure,
                onRetry: () => context.read<RequestLocationPermessionCubit>().requestLocation(),
              )
            ),
          }
        ),
      )
    ),
  );
}