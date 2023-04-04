import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromRGBO(242, 129, 29, 1.0);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
}

class AppTheme {
  static const TextStyle _headingStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    fontFamily: 'Montserrat',
  );

  static const TextStyle _subheadingStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    fontFamily: 'Montserrat',
  );

  static const TextStyle _bodyTextStyle = TextStyle(
    color: AppColors.black,
    fontFamily: 'OpenSans',
  );

  static const TextStyle _subBodyTextStyle = TextStyle(
    color: AppColors.grey,
    fontFamily: 'OpenSans',
  );

  static const TextStyle _labeltextStyle = TextStyle(
    color: AppColors.primary,
    fontFamily: 'OpenSans',
  );

  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.black)),
    iconTheme: const IconThemeData(
      color: AppColors.primary,
    ),
    iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(backgroundColor: AppColors.black)),
    textTheme: TextTheme(
      headlineLarge: _headingStyle.copyWith(fontSize: 32.0),
      headlineMedium: _headingStyle.copyWith(fontSize: 28.0),
      headlineSmall: _headingStyle.copyWith(fontSize: 24.0),
      titleLarge: _headingStyle.copyWith(fontSize: 22.0),
      titleMedium: _subheadingStyle.copyWith(fontSize: 16.0),
      titleSmall: _subheadingStyle.copyWith(fontSize: 14.0),
      bodyLarge: _bodyTextStyle.copyWith(fontSize: 16.0),
      labelLarge: _labeltextStyle.copyWith(fontSize: 16),
      bodyMedium: _subBodyTextStyle.copyWith(fontSize: 14.0),
      bodySmall: _subBodyTextStyle.copyWith(fontSize: 12.0),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: _bodyTextStyle.copyWith(fontSize: 18),
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: AppColors.primary)
        .copyWith(
          background: AppColors.white,
        ),
  );
}
