import 'package:firebase_with_riverpod/core/shared_modules/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/utils_and_services/extensions/context_extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_riverpod/core/shared_presentation/constants/app_constants.dart';
import 'package:firebase_with_riverpod/core/shared_modules/localization/app_strings.dart';
import 'package:firebase_with_riverpod/core/shared_modules/navigation/routes_names.dart';
import 'package:firebase_with_riverpod/core/shared_presentation/widgets/custom_app_bar.dart';
import 'package:firebase_with_riverpod/core/shared_modules/theme/theme_toggle_widget.dart';
import '../../shared_modules/localization/code_base_for_both_options/text_widget.dart';

/// 🏠 [HomePage] — the main landing screen after login.
/// Displays a toggle for theme switching and navigates to profile/settings.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.homePageAppBarTitle,
        actionWidgets: [
          /// 🌗 Theme toggle (light/dark)
          const ThemeToggleIcon(),

          /// 👤 Navigate to profile
          IconButton(
            icon: const Icon(Icons.person_2),
            onPressed: () => context.pushToNamed(RoutesNames.profilePage),
          ).withPaddingRight(AppSpacing.m),
        ],
      ),

      body: Center(
        child: const TextWidget(
          AppStrings.homePageBodyMessage,
          TextType.bodyLarge,
          isTextOnFewStrings: true,
        ).withPaddingHorizontal(AppSpacing.l),
      ),
    );
  }
}
