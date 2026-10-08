import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/profile_image_controller.dart';
import 'image_source_bottom_sheet.dart';

final class EditProfileAvatar extends StatelessWidget {
  static const double _radius = 56.0;

  final String? _imageUrl;
  final ProfileImageController _imageController;

  const new({
    super.key,
    this._imageUrl,
    required this._imageController
  });

  void _showImageSourceSheet(BuildContext context) async{
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (BuildContext _) => const ImageSourceBottomSheet(),
      shape: const RoundedRectangleBorder(
        borderRadius: .vertical(top: .circular(16.0))
      ),
    );

    if(source != null)
      _imageController.pickImage(source);
  }

  // The picked image wins, then the one coming from the API, otherwise the placeholder (child) shows.
  ImageProvider? _getImageProvider(String? pickedImagePath)
  => pickedImagePath != null
    ? FileImage(File(pickedImagePath))
    : _imageUrl != null
      ? CachedNetworkImageProvider(_imageUrl)
      : null;

  @override
  Stack build(BuildContext context)
  => Stack(
    children: <Widget>[
      ValueListenableBuilder<String?>(
        valueListenable: _imageController,
        builder: (BuildContext context, String? pickedImagePath, Widget? placeholder){
          final ImageProvider? imageProvider = _getImageProvider(pickedImagePath);
          return CircleAvatar(
            radius: _radius,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundImage: imageProvider,
            // Keeps the placeholder visible if the image fails to load instead of throwing.
            onForegroundImageError: imageProvider == null
              ? null
              : (Object _, StackTrace? _){},
            child: placeholder,
          );
        },
        child: Icon(
          Icons.person_rounded,
          size: _radius,
          color: Theme.of(context).colorScheme.onPrimaryContainer
        ),
      ),
      Positioned(
        right: 0.0,
        bottom: 0.0,
        child: IconButton.filled(
          onPressed: () => _showImageSourceSheet(context),
          style: IconButton.styleFrom(
            side: BorderSide(
              color: Theme.of(context).colorScheme.surface,
              width: 2.0
            )
          ),
          icon: const Icon(Icons.camera_alt_outlined, size: 20.0)
        ),
      )
    ],
  );
}
