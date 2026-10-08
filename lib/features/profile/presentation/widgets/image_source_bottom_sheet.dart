import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final class ImageSourceBottomSheet extends StatelessWidget {
  const new({super.key});

  @override
  SafeArea build(BuildContext context)
  => SafeArea(
    child: Padding(
      padding: const .symmetric(vertical: 32.0),
      child: Row(
        mainAxisAlignment: .spaceEvenly,
        children: <Widget>[
          IconButton.filledTonal(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            iconSize: 32.0,
            padding: const .all(20.0),
            icon: const Icon(Icons.camera_alt_outlined)
          ),
          IconButton.filledTonal(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            iconSize: 32.0,
            padding: const .all(20.0),
            icon: const Icon(Icons.photo_library_outlined)
          )
        ],
      ),
    ),
  );
}
