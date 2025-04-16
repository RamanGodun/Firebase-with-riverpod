import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_with_riverpod/core/constants/app_strings.dart';
import 'package:firebase_with_riverpod/core/entities/custom_error.dart';
import 'package:firebase_with_riverpod/core/utils_and_services/extensions/context_extensions.dart';
import 'package:firebase_with_riverpod/presentation/widgets/mini_widgets.dart';
import 'package:firebase_with_riverpod/presentation/widgets/text_widget.dart';

/// 🧩 [ErrorHandling] — platform-aware error dialog manager
class ErrorHandling {
  /// 🧼 Shows error as native-style dialog using [MiniWidgets]
  static void showErrorDialog(BuildContext context, CustomError error) {
    final primaryColor = context.colorScheme.primary;
    final dialogContent = MiniWidgets(
      MWType.error,
      error: error,
      isForDialog: true,
    );

    final dialogTitle = const TextWidget(
      AppStrings.errorDialogTitle,
      TextType.titleMedium,
    );

    final okButton =
        defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.macOS
            ? CupertinoDialogAction(
              onPressed: context.popView,
              child: TextWidget(
                AppStrings.okButton,
                TextType.titleMedium,
                color: primaryColor,
              ),
            )
            : TextButton(
              onPressed: context.popView,
              child: TextWidget(
                AppStrings.okButton,
                TextType.titleMedium,
                color: primaryColor,
              ),
            );

    final dialog =
        (defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.macOS)
            ? CupertinoAlertDialog(
              title: dialogTitle,
              content: dialogContent,
              actions: [okButton],
            )
            : AlertDialog(
              title: dialogTitle,
              content: dialogContent,
              actions: [okButton],
            );

    showDialog(context: context, builder: (_) => dialog);
  }
}
