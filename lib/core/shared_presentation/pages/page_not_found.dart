import 'package:firebase_with_riverpod/core/shared_modules/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/shared_presentation/constants/_app_constants.dart';
import 'package:firebase_with_riverpod/core/shared_modules/localization/code_base_for_both_options/app_strings.dart';
import 'package:firebase_with_riverpod/core/shared_presentation/widgets/custom_app_bar.dart';
import 'package:firebase_with_riverpod/core/utils/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import '../../shared_modules/localization/code_base_for_both_options/text_widget.dart';
import '../../shared_modules/navigation/routes_names.dart';
import '../widgets/buttons/custom_buttons.dart';

/// 🧭 [PageNotFound] — generic 404 fallback UI for unknown routes
class PageNotFound extends StatelessWidget {
  final String errorMessage;

  const PageNotFound({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.pageNotFoundTitle),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.m,
          children: [
            /// 🧨 Error message or fallback description
            TextWidget(
              errorMessage.isNotEmpty
                  ? errorMessage
                  : AppStrings.pageNotFoundMessage,
              TextType.error,
            ),

            /// 🏠 Navigation back to home
            CustomButton(
              type: ButtonType.filled,
              onPressed: () => context.goTo(RoutesNames.home),
              label: AppStrings.goToHomeButton,
              isEnabled: true,
              isLoading: false,
            ),
          ],
        ).withPaddingAll(AppSpacing.l),
      ),
    );
  }
}
