import 'package:firebase_with_riverpod/core/modules_shared/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/modules_shared/theme/core/constants/_app_constants.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import '../../../modules_shared/localization/widgets/text_widget.dart';
import '../../../modules_shared/localization/generated/locale_keys.g.dart';
import '../../../modules_shared/navigation/core/routes_names.dart';
import '../widgets_shared/buttons/custom_buttons.dart';

/// 🧭 [PageNotFound] — generic 404 fallback UI for unknown routes
class PageNotFound extends StatelessWidget {
  final String errorMessage;

  const PageNotFound({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.xxxm,
          children: [
            const TextWidget(
              LocaleKeys.errors_page_not_found_title,
              TextType.titleMedium,
            ),

            /// 🧨 Error message or fallback description
            TextWidget(
              errorMessage.isNotEmpty
                  ? errorMessage
                  : LocaleKeys.errors_page_not_found_message,
              TextType.error,
              isTextOnFewStrings: true,
            ),

            /// 🏠 Navigation back to home
            CustomButton(
              type: ButtonType.filled,
              onPressed: () => context.goTo(RoutesNames.home),
              label: LocaleKeys.buttons_go_to_home,
              isEnabled: true,
              isLoading: false,
            ),
          ],
        ).withPaddingAll(AppSpacing.l),
      ),
    );
  }
}

/*

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.xxxm,
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
 */
