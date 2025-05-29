// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'language_option.dart';

// /// 🌐🌍 [LanguageToggleButton] — macOS-style drop-down with flag + native text
// //-------------------------------------------------------------------------

// final class LanguageToggleButton extends StatelessWidget {
//   const LanguageToggleButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final currentLangCode = context.locale.languageCode;

//     return PopupMenuButton<LanguageOption>(
//       tooltip: 'Change Language',
//       padding: EdgeInsets.zero,
//       icon: Icon(
//         AppIcons.language,
//         color: context.colorScheme.primary,
//       ).withPaddingOnly(right: 20),
//       itemBuilder:
//           (_) =>
//               LanguageOption.values
//                   .map((e) => e.toMenuItem(currentLangCode))
//                   .toList(),
//       onSelected: (option) {
//         final showBanner = context.showUserBanner;
//         context.setLocale(option.locale).then((_) {
//           showBanner(message: option.messageKey.tr(), icon: AppIcons.language);
//         });
//       },
//     );
//   }
// }
