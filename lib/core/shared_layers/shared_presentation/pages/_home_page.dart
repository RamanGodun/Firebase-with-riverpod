import 'package:firebase_with_riverpod/core/shared_modules/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_riverpod/core/shared_modules/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_riverpod/core/shared_modules/theme/core/constants/_app_constants.dart';
import 'package:firebase_with_riverpod/core/shared_modules/navigation/routes_names.dart';
import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/widgets/custom_app_bar.dart';
import '../../../shared_modules/localization/code_base_for_both_options/text_widget.dart';

/// 🏠 [HomePage] — the main landing screen after login.
/// Displays a toggle for theme switching and navigates to profile/settings.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.pages_home,
        actionWidgets: [
          /// 👤 Navigate to profile
          IconButton(
            icon: const Icon(Icons.person_2),
            onPressed: () => context.pushToNamed(RoutesNames.profilePage),
          ).withPaddingRight(AppSpacing.m),
        ],
      ),

      body: Center(
        child: const TextWidget(
          LocaleKeys.pages_home_message,
          TextType.bodyLarge,
          isTextOnFewStrings: true,
        ).withPaddingHorizontal(AppSpacing.l),
      ),
    );
  }
}
