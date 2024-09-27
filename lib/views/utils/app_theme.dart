import 'package:flutter/material.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/text_style_extensions.dart';

import 'borders/app_input_decoration_border.dart';

class AppTheme {
  ThemeData getAppTheme() => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
      useMaterial3: true,
      appBarTheme: _appBarTheme(),
      scaffoldBackgroundColor: bgColor,
      elevatedButtonTheme: _buttonThemeData(),
      floatingActionButtonTheme: _floatingActionButtonThemeData,
      dialogTheme: _dialogTheme(),
    inputDecorationTheme: _inputDecorations()
  );

  AppBarTheme _appBarTheme() =>
       AppBarTheme(backgroundColor: primaryColor,titleTextStyle: TextStyle().whiteTitleTextStyle);

  ElevatedButtonThemeData _buttonThemeData() => ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
      ));

  DialogTheme _dialogTheme() =>
      DialogTheme(contentTextStyle: const TextStyle().primaryTextStyle);

  get _floatingActionButtonThemeData =>
      const FloatingActionButtonThemeData(backgroundColor: primaryColor,);

  _inputDecorations()=> InputDecorationTheme(
    border: AppInputDecorationBorder.defaultBorder(),
    errorBorder: AppInputDecorationBorder.errorBorder(),
    focusedBorder: AppInputDecorationBorder.focusedBorder(),
    focusedErrorBorder: AppInputDecorationBorder.focusedErrorBorder(),
    disabledBorder: AppInputDecorationBorder.disabledBorder(),
    // enabledBorder: AppInputDecorationBorder.enabledBorder(),
  );
}
