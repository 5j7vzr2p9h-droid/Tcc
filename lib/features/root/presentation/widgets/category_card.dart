import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

final class CategoryCard extends StatelessWidget {
  final String _title, _image;
  final VoidCallback _onTap;

  const new({
    super.key,
    required this._title,
    required this._image,
    required this._onTap
  });

  @override
  GestureDetector build(BuildContext context)
  => GestureDetector(
    onTap: _onTap,
    child: Stack(
      alignment: .bottomCenter,
      children: <Widget>[
        Container(
          foregroundDecoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Colors.black,
                Colors.transparent
              ],
              begin: .bottomCenter,
              end: .center
            ),
            borderRadius: .all(.circular(12.0)),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                _image,
                maxHeight: 800,
                maxWidth: 800
                ),
              fit: .cover
            ),
            borderRadius: const .all(.circular(12.0)),
          ),
        ),
        Padding(
          padding: const .only(bottom: 12.0),
          child: Text(
          _title.toUpperCase(),
            style: TextStyles.font20Weight900.copyWith(
              color: Colors.white
            ),
          ),
        ),
      ],
    ),
  );
}