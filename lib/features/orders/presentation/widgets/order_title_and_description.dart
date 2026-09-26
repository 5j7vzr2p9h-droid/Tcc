import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

class OrderTitleAndDescription extends StatelessWidget {
  final String _title, _description;

  const new({
    super.key,
    required this._title,
    required this._description
  });

  @override
  Column build(BuildContext context)
  => Column(
    crossAxisAlignment: .start,
    children: <Text>[
      Text(
        _title,
        style: TextStyles.font24Weight700.copyWith(height: 1.0)
      ),
      Text(
        _description,
        style: const TextStyle(color: Colors.grey)
      ),
    ],
  );
}