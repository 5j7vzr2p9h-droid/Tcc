import 'package:flutter/material.dart';

import '../../../../core/enums/field_status.dart';
import '../../../../core/extensions/context_l10n.dart';
import '../../../../core/utils/text_styles.dart';
import '../../../root/domain/entities/item_entity.dart';
import 'exclusive_option_marker.dart';
import 'food_addition_tile.dart';
import 'order_field_title.dart';

final class ConditionalGroupField extends StatelessWidget {
  final ConditionalGroupEntity _group;
  /// Indexes of the selected [ConditionalGroupEntity.options].
  final ValueNotifier<Set<int>> _controller;

  const new({
    super.key,
    required this._group,
    required this._controller
  });

  bool get _hasExclusiveOptions
  => _group.options.any((ConditionalOptionEntity option) => !option.allowCombine);

  /// An option that can't be combined is always picked alone,
  /// and picking one that can drops any option that can't.
  Set<int> _select(Set<int> selectedIndexes, int i){
    if(!_group.options[i].allowCombine || _group.maxSelection == 1) return <int>{i};
    return <int>{
      for(final int j in selectedIndexes)
        if(_group.options[j].allowCombine) j,
      i
    };
  }

  /// A [ConditionalGroupEntity.maxSelection] of 0 means there's no limit.
  bool _exceedsMax(Set<int> selectedIndexes)
  => _group.maxSelection > 0 && selectedIndexes.length > _group.maxSelection;

  String? _hint(BuildContext context) => switch(_group.maxSelection){
    1 => context.l10n.chooseOne,
    > 1 => context.l10n.chooseUpTo(_group.maxSelection),
    _ => null
  };

  @override
  Column build(BuildContext context){
    final String? hint = _hint(context);
    final TextStyle hintStyle = TextStyles.font12Weight400.copyWith(color: Colors.grey);

    return Column(
      crossAxisAlignment: .start,
      children: <Widget>[
        OrderFieldTitle(
          title: _group.name,
          fieldStatus: _group.minSelection > 0 ? FieldStatus.mandatory : FieldStatus.optional
        ),
        if(hint != null) ...<Widget>[
          const SizedBox(height: 4.0),
          Text(hint, style: hintStyle)
        ],
        if(_hasExclusiveOptions) ...<Widget>[
          const SizedBox(height: 4.0),
          Row(
            spacing: 6.0,
            children: <Widget>[
              const ExclusiveOptionMarker(),
              Expanded(
                child: Text(context.l10n.cannotBeCombined, style: hintStyle)
              )
            ],
          )
        ],
        const SizedBox(height: 4.0),
        Material(
          clipBehavior: .antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: .circular(16.0),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline
            ),
          ),
          child: ValueListenableBuilder<Set<int>>(
            valueListenable: _controller,
            builder: (BuildContext context, Set<int> selectedIndexes, Widget? child)
            => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: .zero,
              itemCount: _group.options.length,
              separatorBuilder: (BuildContext _, int _) => Divider(
                color: Theme.of(context).colorScheme.outline,
                height: 1.0,
              ),
              itemBuilder: (BuildContext context, int i){
                final ConditionalOptionEntity option = _group.options[i];
                final bool isSelected = selectedIndexes.contains(i);

                return FoodAdditionTile(
                  title: option.name,
                  price: option.price > 0 ? option.price : null,
                  value: isSelected,
                  enabled: isSelected || !_exceedsMax(_select(selectedIndexes, i)),
                  isExclusive: !option.allowCombine,
                  onChanged: (bool isChecked) => _controller.value = isChecked
                    ? _select(selectedIndexes, i)
                    : (<int>{...selectedIndexes}..remove(i))
                );
              }
            ),
          ),
        )
      ],
    );
  }
}
