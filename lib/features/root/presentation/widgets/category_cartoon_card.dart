import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

class CategoryCartoonCard extends StatelessWidget {
  const new({super.key});

  @override
  GestureDetector build(BuildContext context)
  => GestureDetector(
    onTap: (){},
    child: Card(
      child: Padding(
        padding: const .all(6.0),
        child: Column(
          children: <Widget>[
            Image.network(
              "https://img.magnific.com/premium-vector/beef-burger-with-cheddar-coleslaw-beef-patty-lettuce-brioche-bun-without-sesame_1249410-48315.jpg",
              height: 60.0,
            ),
            Text(
              "Burgers",
              style: TextStyles.font12Weight700
            ),
            Text(
              "-",
              style: TextStyles.font14Weight700.copyWith(
                color: Theme.of(context).colorScheme.primary
              ),
            )
          ],
        ),
      ),
    ),
  );
}