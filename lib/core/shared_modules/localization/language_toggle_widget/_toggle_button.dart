import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:firebase_with_riverpod/core/utils/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import '../../../shared_layers/shared_presentation/constants/_app_constants.dart';
import '../../overlays/simple_overlay/overlay_service.dart';
import 'language_option.dart';

/// 🌐🌍 [LanguageToggleButton] — macOS-style drop-down with flag + native text
//-------------------------------------------------------------------------

final class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLangCode = context.locale.languageCode;

    return PopupMenuButton<LanguageOption>(
      tooltip: 'Change Language',
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
        final overlay = Overlay.of(context, rootOverlay: true);
        final message = option.messageKey.tr();

        SchedulerBinding.instance.addPostFrameCallback((_) async {
          await context.setLocale(option.locale);
          // context.setLocale(option.locale).then((_) {
          // showBanner(message: option.messageKey.tr(), icon: AppIcons.language);

          // 🧃 Show feedback to user
          OverlayNotificationService.showOverlayViaOverlay(
            overlay,
            message: message,
            icon: AppIcons.language,
          );
        });
      },
    );
  }
}
