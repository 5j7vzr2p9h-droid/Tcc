import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color? optional,
    mandatory,
    placeHolderBackground,
    placeHolderForeground;

  const AppColors({
    required this.optional,
    required this.mandatory,
    required this.placeHolderBackground,
    required this.placeHolderForeground
  });

  @override
  AppColors copyWith({
    Color? optional,
    Color? mandatory,
    Color? placeHolderBackground,
    Color? placeHolderForeground
  })
  => AppColors(
    optional: optional ?? this.optional,
    mandatory: mandatory ?? this.mandatory,
    placeHolderBackground: placeHolderBackground ?? this.placeHolderBackground,
    placeHolderForeground: placeHolderForeground ?? this.placeHolderForeground
  );

  @override
  AppColors lerp(AppColors? other, double t)
  => other is! AppColors? this:
  AppColors(
    optional: Color.lerp(optional, other.optional, t),
    mandatory: Color.lerp(mandatory, other.mandatory, t),
    placeHolderBackground: Color.lerp(placeHolderBackground, other.placeHolderBackground, t),
    placeHolderForeground: Color.lerp(placeHolderForeground, other.placeHolderForeground, t)
  );

  static AppColors of(BuildContext context)
  => Theme.of(context).extension<AppColors>()!;
}