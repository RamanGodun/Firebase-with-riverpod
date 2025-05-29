import 'package:firebase_with_riverpod/core/utils/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_riverpod/core/shared_presentation/constants/_app_constants.dart';
import 'package:firebase_with_riverpod/core/shared_modules/localization/code_base_for_both_options/app_strings.dart';
import 'package:firebase_with_riverpod/core/shared_presentation/widgets/buttons/custom_buttons.dart';

import '../../shared_modules/localization/code_base_for_both_options/text_widget.dart';

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
            const TextWidget(AppStrings.firebaseErrorTitle, TextType.error),
            const TextWidget(
              AppStrings.firebaseErrorMessage,
              TextType.bodyMedium,
            ),
            const SizedBox(height: 20.0),
            CustomButton(
              type: ButtonType.filled,
              onPressed: () => Navigator.pop(context),
              label: AppStrings.retryButton,
              isEnabled: true,
              isLoading: false,
            ),
          ],
        ).withPaddingHorizontal(AppSpacing.l),
      ),
    );
  }
}
