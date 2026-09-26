import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'product_placeholder.dart';

final class HandledNetworkImage extends StatelessWidget {
  final String _imageUrl;
  final double? _width, _height;
  final int? _cacheWidth, _cacheHeight;
  final Color? _color;
  final BlendMode? _blendMode;

  const new({
    super.key,
    required this._imageUrl,
    this._width,
    this._height,
    this._cacheWidth,
    this._cacheHeight,
    this._color,
    this._blendMode
  });

  @override
  CachedNetworkImage build(BuildContext context)
  => CachedNetworkImage(
    imageUrl: _imageUrl,
    width: _width,
    height: _height,
    memCacheWidth: _cacheWidth ?? _width?.toInt(),
    memCacheHeight: _cacheHeight ?? _height?.toInt(),
    maxWidthDiskCache: _cacheWidth ?? _width?.toInt(),
    maxHeightDiskCache: _cacheHeight ?? _height?.toInt(),
    color: _color,
    colorBlendMode: _blendMode,
    fit: .cover,
    errorWidget: (BuildContext context, String url, Object error)
    => const ProductPlaceholder(),
  );
}