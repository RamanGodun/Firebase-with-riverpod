part of 'theme_type_enum.dart.dart';

// 🎨 Enhanced enum for ThemeType
extension ThemeTypesX on ThemeTypes {
  ///----------------------------------

  ///
  ThemeData buildTheme({FontFamily? font}) {
    //
    final fontFamily = (font ?? FontFamily.sfPro).value;

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: background,
      primaryColor: primaryColor,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: contrastColor,
        actionsIconTheme: IconThemeData(color: primaryColor),
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: contrastColor,
        ),
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: AppColors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: UIConstants.commonBorderRadius,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          elevation: 0.5,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        shape: const RoundedRectangleBorder(
          borderRadius: UIConstants.commonBorderRadius,
        ),
        shadowColor: AppColors.shadow,
        elevation: 5,
      ),
      textTheme: TextThemeFactory.fromBrightness(brightness, font: font),
    );
  }

  //
}
