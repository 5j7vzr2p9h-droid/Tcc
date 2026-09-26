import 'package:flutter/material.dart';

import '../../core/utils/text_styles.dart';
import 'app_colors.dart';

final ThemeData lightTheme = ThemeData(
  extensions: const <ThemeExtension<dynamic>>[
    AppColors(
      optional: Colors.green,
      mandatory: Colors.redAccent,
      placeHolderBackground: Color.fromARGB(255, 213, 213, 213),
      placeHolderForeground: Color.fromARGB(255, 163, 163, 163)
    )
  ],

  scaffoldBackgroundColor: Colors.grey.shade200,
  colorScheme: ColorScheme(
    brightness: .light,
    primary: Colors.green,
    onPrimary: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
    secondary: Colors.white,
    onSecondary: Colors.green,
    error: Colors.red,
    errorContainer: Colors.red.shade100,
    onError: Colors.white,
    outline: Colors.grey.shade300
  ),

  checkboxTheme: const CheckboxThemeData(
    side: BorderSide(
      color: Colors.grey
    )
  ),

  radioTheme: const RadioThemeData(
    side: BorderSide(
      color: Colors.grey
    ),
  ),

  inputDecorationTheme: InputDecorationThemeData(
    isDense: true,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    hintStyle: const TextStyle(
      color: Colors.grey
    ),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: const .all(.circular(8.0)),
      borderSide: BorderSide(color: Colors.grey.shade300)
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const .all(.circular(8.0)),
      borderSide: BorderSide(color: Colors.grey.shade300)
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: .all(.circular(8.0)),
      borderSide: BorderSide(color: Colors.red)
    )
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      textStyle: TextStyles.font16Weight700,
      minimumSize: const .fromHeight(48.0),
      shape: const RoundedRectangleBorder(
        borderRadius: .all(.circular(12.0))
      )
    )
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.green,
      textStyle: TextStyles.font14Weight700,
      side: const BorderSide(color: Color(0xFF83c73e)),
      shape: const RoundedRectangleBorder(
        borderRadius: .all(.circular(12.0))
      )
    )
  ),
  
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: TextStyles.font14Weight700
    )
  ),

  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyles.font16Weight700.copyWith(
      color: Colors.black
    ),
    subtitleTextStyle: TextStyles.font12Weight400.copyWith(color: Colors.grey)
  )
);
