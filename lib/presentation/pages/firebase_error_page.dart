import 'package:flutter/material.dart';
import 'package:firebase_with_riverpod/core/constants/app_constants.dart';
import 'package:firebase_with_riverpod/core/constants/app_strings.dart';
import 'package:firebase_with_riverpod/core/utils_and_services/extensions/others.dart';
import 'package:firebase_with_riverpod/presentation/widgets/buttons/custom_buttons.dart';
import 'package:firebase_with_riverpod/presentation/widgets/text_widget.dart';

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
