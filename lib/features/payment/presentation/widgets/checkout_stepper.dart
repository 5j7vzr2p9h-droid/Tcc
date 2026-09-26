import 'package:flutter/material.dart';

import '../../../../core/constants/numerical_values.dart';
import '../../../../core/utils/text_styles.dart';

final class CheckoutStepper extends StatelessWidget {
  final List<String> _steps;
  final int _currentStep;
  final ValueChanged<int> _onClickedOnDone;

  const new({
    super.key,
    required this._steps,
    required this._currentStep,
    required this._onClickedOnDone
  });

  @override
  SliverToBoxAdapter build(BuildContext context)
  => SliverToBoxAdapter(
    child: Padding(
      padding: const .all(pageContentPadding),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 16.0,
            left: 0.0,
            right: 0.0,
            child: Divider(
              color: Theme.of(context).colorScheme.primary,
              height: 1.0,
              thickness: 2.0,
            ),
          ),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: List<GestureDetector>.generate(
              _steps.length,
              (int i) {
                final int stepNumber = i + 1;
                final bool isDone = stepNumber < _currentStep;
                return GestureDetector(
                  onTap: isDone? () => _onClickedOnDone(stepNumber): null,
                  child: CheckoutStepIndicator(
                    index: i + 1,
                    label: _steps[i],
                    done: isDone
                  ),
                );
              },
            )
          ),
        ],
      ),
    ),
  );
}

final class CheckoutStepIndicator extends StatelessWidget {
  final int _index;
  final String _label;
  final bool _done;

  const new({
    super.key,
    required this._index,
    required this._label,
    required this._done,
  });

  @override
  Column build(BuildContext context) => Column(
      spacing: 8.0,
      children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          alignment: .center,
          decoration: BoxDecoration(
            shape: .circle,
            color: _done? Theme.of(context).colorScheme.primary: Theme.of(context).colorScheme.surface,
            border: .all(
              color: Theme.of(context).colorScheme.primary,
              width: 2.0
            )
          ),
          child: _done?
            Icon(Icons.check, color: Theme.of(context).colorScheme.onPrimary, size: 18.0):
            Text(
              "$_index",
              style: TextStyles.font14Weight700.copyWith(
                color: Theme.of(context).colorScheme.primary
              )
            )
        ),
        Text(
          _label,
          style: TextStyles.font12Weight700.copyWith(
            color: _done? Colors.grey: Theme.of(context).colorScheme.primary
          )
        )
      ],
    );
}
