import 'package:firebase_with_riverpod/core/shared_modules/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/theme/core/constants/_app_constants.dart';
import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import '../../../shared_modules/localization/code_base_for_both_options/text_widget.dart';
import '../../../shared_modules/localization/generated/locale_keys.g.dart';
import '../../../shared_modules/navigation/routes_names.dart';
import '../widgets/buttons/custom_buttons.dart';

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
