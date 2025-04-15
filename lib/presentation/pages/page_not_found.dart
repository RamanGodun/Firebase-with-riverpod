import 'package:firebase_with_riverpod/core/constants/app_constants.dart';
import 'package:firebase_with_riverpod/core/constants/app_strings.dart';
import 'package:firebase_with_riverpod/core/utils_and_services/extensions/context_extensions.dart';
import 'package:firebase_with_riverpod/core/utils_and_services/extensions/others.dart';
import 'package:firebase_with_riverpod/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import '../../core/router/routes_names.dart';
import '../widgets/buttons/custom_buttons.dart';
import '../widgets/text_widget.dart';

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
