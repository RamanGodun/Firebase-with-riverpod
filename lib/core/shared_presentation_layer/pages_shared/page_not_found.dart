import 'package:firebase_with_riverpod/core/foundation/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/foundation/theme/ui_constants/_app_constants.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import '../../foundation/localization/widgets/text_widget.dart';
import '../../foundation/localization/generated/locale_keys.g.dart';
import '../../foundation/navigation/app_routes/app_routes.dart';
import '../widgets_shared/buttons/filled_button.dart';

/// 🧭 [PageNotFound] — generic 404 fallback UI for unknown routes

class PageNotFound extends StatelessWidget {
  //---------------------------------------

  final String errorMessage;
  const PageNotFound({super.key, required this.errorMessage});
  //

  @override
  Widget build(BuildContext context) {
    //
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
            CustomFilledButton(
              onPressed: () => context.goTo(RoutesNames.home),
              label: LocaleKeys.buttons_go_to_home,
            ),
          ],
        ).withPaddingAll(AppSpacing.l),
      ),
    );
  }
}
