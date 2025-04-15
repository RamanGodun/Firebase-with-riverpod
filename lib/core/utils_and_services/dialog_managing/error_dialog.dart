import 'package:firebase_with_riverpod/core/utils_and_services/extensions/context_extensions.dart';
import 'package:firebase_with_riverpod/presentation/widgets/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../entities/custom_error.dart';

class ErrorHandling {
  static void showErrorDialog(BuildContext context, CustomError e) {
    final colorScheme = context.colorScheme;
    final primaryColor = colorScheme.primary;
    final isIOS =
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;

    isIOS
        ? showCupertinoDialog(
          context: context,
          builder:
              (context) => CupertinoAlertDialog(
                title: TextWidget(e.code, TextType.titleMedium),
                content: TextWidget(
                  'plugin: ${e.plugin}\n\n${e.message}',
                  TextType.error,
                ),
                actions: [
                  CupertinoDialogAction(
                    child: TextWidget(
                      'OK',
                      TextType.titleMedium,
                      color: primaryColor,
                    ),
                    onPressed: () => context.popView,
                  ),
                ],
              ),
        )
        : showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: TextWidget(e.code, TextType.titleMedium),
                content: TextWidget(
                  'plugin: ${e.plugin}\n\n${e.message}',
                  TextType.error,
                ),
                actions: [
                  TextButton(
                    child: TextWidget(
                      'OK',
                      TextType.titleMedium,
                      color: primaryColor,
                    ),
                    onPressed: () => context.popView,
                  ),
                ],
              ),
        );
  }
}
