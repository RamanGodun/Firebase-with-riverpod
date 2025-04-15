import 'package:flutter/material.dart';
import 'package:firebase_with_riverpod/core/constants/app_strings.dart';
import 'text_widget.dart';

/// 🔧 Enum for defining types of mini UI widgets
enum MWType { loading, error }

/// 📦 [MiniWidgets] — lightweight reusable widgets for loading & error display
class MiniWidgets extends StatelessWidget {
  final MWType type;
  final Object? error;
  final StackTrace? stackTrace;

  const MiniWidgets(this.type, {super.key, this.error, this.stackTrace});

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      ///
      MWType.loading => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),

      /// ?  It's necessary to handle StackTrace st value (if it available)
      MWType.error => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TextWidget(
              AppStrings.pageNotFoundMessage,
              TextType.error,
              isTextOnFewStrings: true,
            ),
            if (error != null) ...[
              const SizedBox(height: 10),
              TextWidget(
                error.toString(),
                TextType.caption,
                isTextOnFewStrings: true,
              ),
            ],
          ],
        ),
      ),
    };
  }
}
