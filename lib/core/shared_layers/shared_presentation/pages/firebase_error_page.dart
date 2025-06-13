import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_riverpod/core/shared_modules/theme/core/constants/_app_constants.dart';
import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/widgets/buttons/custom_buttons.dart';

import '../../../shared_modules/localization/code_base_for_both_options/text_widget.dart';
import '../../../shared_modules/localization/generated/locale_keys.g.dart';

/// 🔥 [FirebaseErrorPage] — shown when Firebase initialization fails or has a runtime error.
/// Displays fallback UI with retry option.
class FirebaseErrorPage extends StatelessWidget {
  const FirebaseErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.m,
          children: [
            const TextWidget(LocaleKeys.errors_firebase_title, TextType.error),
            const TextWidget(
              LocaleKeys.errors_firebase_message,
              TextType.bodyMedium,
            ),
            const SizedBox(height: 20.0),
            CustomButton(
              type: ButtonType.filled,
              onPressed: () => Navigator.pop(context),
              label: LocaleKeys.buttons_retry,
              isEnabled: true,
              isLoading: false,
            ),
          ],
        ).withPaddingHorizontal(AppSpacing.l),
      ),
    );
  }
}
