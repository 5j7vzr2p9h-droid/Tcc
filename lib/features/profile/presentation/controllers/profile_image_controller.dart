import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Holds the local path of the image the user picked, or null if nothing was picked yet.
final class ProfileImageController extends ValueNotifier<String?>{
  final ImagePicker _imagePicker;

  new(this._imagePicker): super(null);

  Future<void> pickImage(ImageSource source) async{
    final XFile? xFile = await _imagePicker.pickImage(
      source: source,
      maxWidth: 1024.0,
      imageQuality: 85
    );

    if(xFile != null)
      value = xFile.path;
  }
}
