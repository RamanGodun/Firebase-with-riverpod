import 'package:firebase_with_riverpod/core/shared_modules/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/constants/_app_constants.dart';
import 'package:firebase_with_riverpod/core/utils/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import '../../../shared_modules/errors_handling/old/custom_error.dart';
import '../../../shared_modules/localization/code_base_for_both_options/text_widget.dart';

/// 🔧 Enum for defining types of mini UI widgets
enum MWType { loading, error }

/// 📦 [MiniWidgets] — lightweight reusable widgets for loading & error display
class MiniWidgets extends StatelessWidget {
  final MWType type;
  final CustomError? error;
  // final Object? error;
  final StackTrace? stackTrace;
  final String? errorDialogTitle;
  final bool isForDialog;

  const MiniWidgets(
    this.type, {
    super.key,
    this.error,
    this.stackTrace,
    this.errorDialogTitle,
    this.isForDialog = true,
  });

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      MWType.loading => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      MWType.error => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isForDialog == false)
              TextWidget(
                errorDialogTitle ?? LocaleKeys.errors_error_dialog,
                TextType.error,
                isTextOnFewStrings: true,
              ),
            if (error != null) ...[
              const SizedBox(height: 10),
              TextWidget(
                _formatError(error!),
                TextType.bodySmall,
                isTextOnFewStrings: true,
                alignment: TextAlign.left,
              ),
            ],
          ],
        ).withPaddingHorizontal(AppSpacing.l),
      ),
    };
  }

  /// 🧠 Fallback-safe formatter for [CustomError]
  String _formatError(CustomError error) {
    final code = error.code.isNotEmpty ? error.code : 'unknown';
    final plugin = error.plugin.isNotEmpty ? error.plugin : 'unknown';
    final message =
        error.message.isNotEmpty ? error.message : 'Something went wrong';

    return 'code: $code\nplugin: $plugin\nmessage: $message';
  }
}
