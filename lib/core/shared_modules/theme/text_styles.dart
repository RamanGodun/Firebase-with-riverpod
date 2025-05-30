// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// /// 🎨 [TextStyles4ThisAppThemes] — Defines all base typography styles for the app.
// abstract class TextStyles4ThisAppThemes {
//   /// 📌 Generates [TextTheme] using SF Pro Text based on [isDarkTheme].
//   static TextTheme materialTextTheme(bool isDarkTheme) {
//     return TextTheme(
//       titleLarge: _style(isDarkTheme, FontWeight.w600, 22),
//       titleMedium: _style(isDarkTheme, FontWeight.w500, 19),
//       titleSmall: _style(isDarkTheme, FontWeight.w400, 16),
//       bodyLarge: _style(isDarkTheme, FontWeight.w400, 17),
//       bodyMedium: _style(isDarkTheme, FontWeight.w400, 15),
//       bodySmall: _style(isDarkTheme, FontWeight.w400, 13),
//       labelLarge: _style(isDarkTheme, FontWeight.w500, 15),
//       labelMedium: _style(isDarkTheme, FontWeight.w400, 13),
//       labelSmall: _style(isDarkTheme, FontWeight.w400, 11),
//     );
//   }

//   /// 🍏 Cupertino text theme (used automatically in Cupertino widgets).
//   static CupertinoTextThemeData cupertinoTextTheme() {
//     return const CupertinoTextThemeData(
//       primaryColor: CupertinoColors.label,
//       textStyle: TextStyle(
//         fontFamily: 'SFProText',
//         fontSize: 17,
//         fontWeight: FontWeight.w400,
//         color: CupertinoColors.label,
//       ),
//     );
//   }

//   /// 🧱 Reusable base [TextStyle] builder
//   static TextStyle _style(bool isDark, FontWeight weight, double size) {
//     return TextStyle(
//       fontFamily: 'SFProText',
//       fontWeight: weight,
//       fontSize: size,
//       color: isDark ? Colors.white : Colors.black,
//     );
//   }
// }
