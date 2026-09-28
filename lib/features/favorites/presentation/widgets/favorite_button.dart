import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/failure_message.dart';
import '../../../../core/utils/snack_bar_message.dart';
import '../../../../di.dart';
import '../viewmodel/favorite_toggle_viewmodel/favorite_toggle_cubit.dart';
import '../viewmodel/favorite_toggle_viewmodel/favorite_toggle_state.dart';

final class FavoriteButton extends StatelessWidget {
  final int _productId;
  final bool _isFavorite;
  final ValueChanged<bool>? _onChanged;

  const new({
    super.key,
    required this._productId,
    required this._isFavorite,
    this._onChanged
  });

  @override
  BlocProvider<FavoriteToggleCubit> build(BuildContext context)
  => BlocProvider<FavoriteToggleCubit>(
    create: (BuildContext context) => getIt<FavoriteToggleCubit>(
      param1: _productId,
      param2: _isFavorite
    ),
    child: BlocConsumer<FavoriteToggleCubit, FavoriteToggleState>(
      listener: (BuildContext context, FavoriteToggleState state){
        if(state is FavoriteToggleSuccessState)
          _onChanged?.call(state.isFavorite);
        else if(state is FavoriteToggleFailureState)
          SnackBarMessage.showErrorMessage(
            context,
            state.failure.mapFailureToMessage(context)
          );
      },
      builder: (BuildContext context, FavoriteToggleState state)
      => IconButton(
        onPressed: context.read<FavoriteToggleCubit>().toggle,
        color: state.isFavorite
          ? Theme.of(context).colorScheme.primary
          : Colors.grey,
        icon: Icon(state.isFavorite
          ? Icons.favorite
          : Icons.favorite_outline
        )
      ),
    ),
  );
}
