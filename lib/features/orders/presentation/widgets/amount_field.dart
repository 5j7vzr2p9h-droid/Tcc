import 'package:flutter/material.dart';

import '../../../../core/enums/field_status.dart';
import '../../../root/domain/entities/item_entity.dart';
import 'amount_option.dart';
import 'order_field_title.dart';

final class AmountField extends StatefulWidget {
  final ValueNotifier<int?> _controller;
  final String _title;
  final List<MenuSizeEntity> _sizes;

  const new({
    super.key,
    required this._controller,
    required this._title,
    required this._sizes
  });

  @override
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
  @override
  Column build(BuildContext context)
  => Column(
    children: <Widget>[
      OrderFieldTitle(
        title: widget._title,
        fieldStatus: FieldStatus.mandatory,
      ),
      const SizedBox(height: 4.0),
      Material(
        clipBehavior: .antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
            borderRadius: .circular(16.0),
            side: BorderSide(color: Theme.of(context).colorScheme.outline)
        ),
        child: ValueListenableBuilder<int?>(
          valueListenable: widget._controller,
          builder: (BuildContext context, int? value, Widget? child)
          => RadioGroup<int>(
            groupValue: value,
            onChanged: (int? newValue) => widget._controller.value = newValue!,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: .zero,
              itemCount: widget._sizes.length,
              separatorBuilder: (BuildContext _, int _) => Divider(
                color: Theme.of(context).colorScheme.outline,
                height: 1.0,
              ),
              itemBuilder: (BuildContext context, int i) => AmountOption(
                currentValue: i,
                title: widget._sizes[i].name,
                price: widget._sizes[i].price
              ),
              ),
            )
        ),
      )
    ],
  );
}