import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/shared_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_riverpod/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import '../../../shared_layers/shared_presentation/constants/_app_constants.dart';
import 'language_option.dart';

/// 🌐🌍 [LanguageToggleButton] — macOS-style drop-down with flag + native text
//-------------------------------------------------------------------------

final class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    //
    final currentLangCode = context.locale.languageCode;

    return PopupMenuButton<LanguageOption>(
      padding: EdgeInsets.zero,
      icon: Icon(
        AppIcons.language,
        color: context.colorScheme.primary,
      ).withPaddingOnly(right: 20),
      itemBuilder:
          (_) =>
              LanguageOption.values
                  .map((e) => e.toMenuItem(currentLangCode))
                  .toList(),
      onSelected: (option) {
        // final showBanner = context.showUserBanner;
        final showDialog = context.showUserDialog;

        // 🌟 Show overlay with correct message and icon
        context.setLocale(option.locale).then((_) {
          showDialog(
            title: 'Success',
            isDismissible: false,
            isInfoDialog: true,
            content: option.messageKey.tr(),
          );
          // showBanner(message: option.messageKey.tr(), icon: AppIcons.language);

          ///
        });
      },
    );
  }
}
