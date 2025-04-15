import 'package:firebase_with_riverpod/core/utils_and_services/extensions/others.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../widgets/old_buttons.dart';
import '../widgets/text_widget.dart';

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
            const TextWidget('Firebase Connection Error', TextType.error),
            const TextWidget('Please try again later!', TextType.bodyMedium),
            const SizedBox(height: 20.0),
            CustomButton(
              type: ButtonType.filled,
              onPressed: () => Navigator.pop(context),
              label: 'Retry',
              isEnabled: true,
              isLoading: false,
            ),
          ],
        ).withPaddingHorizontal(AppSpacing.l),
      ),
    );
  }
}
